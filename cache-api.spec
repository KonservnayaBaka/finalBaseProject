Name:           cache-api
Version:        1.1
Release:        1%{?dist}
Summary:        Flask proxy with Redis caching layer
License:        MIT
BuildArch:      noarch
Requires:       python3
Source0:        %{name}-%{version}.tar.gz

%description
Flask-based proxy application

%prep
%setup -q -n %{name}-%{version}

%install
rm -rf %{buildroot}

mkdir -p %{buildroot}/usr/bin
mkdir -p %{buildroot}/etc/cache-api
mkdir -p %{buildroot}%{_unitdir}

install -m 0755 cache-api.py          %{buildroot}/usr/bin/cache-api.py
install -m 0644 config-api.yaml       %{buildroot}/etc/cache-api/config.yaml
install -m 0644 cache-api.service     %{buildroot}%{_unitdir}/cache-api.service

%files
%defattr(-,root,root,-)
/usr/bin/cache-api.py
%config(noreplace) /etc/cache-api/config.yaml
%{_unitdir}/cache-api.service

%post
python3 -m pip install --upgrade pip --quiet
python3 -m pip install flask redis requests pyyaml --quiet

%systemd_post cache-api.service

%preun
%systemd_preun cache-api.service

%postun
%systemd_postun cache-api.service

%changelog
* Mon Apr 13 2026 Lev Groshev - 1.1-1
- Added automatic installation of Python dep
