Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v36I7Eqp013474
 for <selinux@tycho.nsa.gov>; Thu, 6 Apr 2017 14:07:15 -0400
Received: by mail-qt0-f169.google.com with SMTP id x35so42933338qtc.2
 for <selinux@tycho.nsa.gov>; Thu, 06 Apr 2017 11:07:10 -0700 (PDT)
MIME-Version: 1.0
From: Carlos Rodrigues <cefrodrigues@gmail.com>
Date: Thu, 6 Apr 2017 19:06:29 +0100
Message-ID: <CAENH-vDt_dcKrW+eGA0b1Mt1xzxEVDOUJ=yf6bbVWZbRkWzH9g@mail.gmail.com>
Subject: Setting booleans causes duplicate ports in semanage listings
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I've noticed a strange interaction with custom ports and booleans.
After setting a boolean, the list of ports for a particular type
(which has been customized) shows duplicate entries.

Example:

    $ semanage port -a -t http_port_t -p tcp 12345
    $ semanage port -l | grep http_port_t
    http_port_t                    tcp      12345, 80, 81, ...
    $ semanage port -l | grep http_port_t
    http_port_t                    tcp      12345, 12345, 80, 81, ...
    $ setsebool -P zebra_write_config false
    $ semanage port -l | grep http_port_t
    http_port_t                    tcp      12345, 12345, 12345, 80, 81, ...

As can be seen, each time a boolean is set persistently (it doesn't
matter which boolean or which state), the custom port 12345 is
duplicated. Running "semodule -B" clears the duplicates.

However, if only the local customizations are listed, the port is
always listed only once:

    $ semanage port -l -C
    SELinux Port Type              Proto    Port Number
    http_port_t                    tcp      12345

I'm using CentOS, but this is reproducible on Fedora 25 as well.

I submitted this originally at
https://github.com/SELinuxProject/selinux/issues/50
Also on RH bugzilla here: https://bugzilla.redhat.com/show_bug.cgi?id=1439875

Best regards,

Carlos Rodrigues
