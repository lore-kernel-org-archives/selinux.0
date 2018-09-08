Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w88AA68G021580
 for <selinux@tycho.nsa.gov>; Sat, 8 Sep 2018 06:10:06 -0400
Received: by mail-ua1-f45.google.com with SMTP id r15-v6so13837968uao.1
 for <selinux@tycho.nsa.gov>; Sat, 08 Sep 2018 03:09:58 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sat, 8 Sep 2018 12:09:46 +0200
Message-ID: <CAJ2a_DfYR=_brdtA-FWAfPU9rRW94E-xfusrN2dkdrWaRj9bfA@mail.gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: systemd unit improvements
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

in the past systemd was checking operation on systemd units, like
enable, disable... , when using systemctl.
This feature was removed three years ago [1] and nowadays only {
reload start status stop } are checked.
I am trying to re-enable these checks with a new approach [2].

With this pull request I also would like to specify some permissions
more precisely:
    - method_kexec:                                 reboot -> kexec
    - method_switch_root:                         reboot -> switchroot
    - method_set_environment:                  reload -> environment
    - method_unset_environment:              reload -> environment
    - method_unset_and_set_environment: reload -> environment
    - bus_unit_method_set_properties:       start -> setproperties
    - bus_unit_method_ref:                        start -> ref

The new introduced checks are computed like:
    source context: process context of the dbus client
    target context:   either the file context of the installation path
for the requested unit (like ssh -> /lib/systemd/system/ssh.service ->
sshd_unit_t) if the file exists, or the process context of systemd
(init_t)
                            so when operating on edited units (like
/etc/systemd/system/ssh.service) the access is still checked against
the original unit context
    class:               "service"
    permission:       verb close to the action (like "enable", "preset"...)

Any comments are appreciated.

Best regards,
     Christian Göttsche


[1]: https://github.com/systemd/systemd/commit/8faae625dc9b6322db452937f54176e56e65265a
[2]: https://github.com/systemd/systemd/pull/10023
