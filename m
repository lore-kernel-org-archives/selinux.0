To: Selinux@tycho.nsa.gov
From: Ralf Spenneberg <ralf@os-t.de>
Subject: DBus
Message-ID: <de5a0b64-266d-3a58-ecee-a6b56690181d@os-t.de>
Date: Mon, 29 Aug 2016 07:53:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,
we have played around with dbus and SELinux on embedded platforms. The
only available documentation appears to be the dbus manpage.
Unfortunately the example concerning the associate given in this manpage
is not correct:
<associate own="org.freedesktop.Foobar" context="foo_t"/>
This should associate the ownership of the dbus service
org.freedesktop.Foobar to the selinux domain foo_t.
Actually you have to specify the full security context:
<associate own="org.freedesktop.Foobar"
context="system_u:object_r:foo_t:s0"/>

I just thought that I mention it on this mailing list as well. A bug has
been posted at
https://bugs.freedesktop.org/show_bug.cgi?id=97528

Kind regards,
Ralf

-- 
OpenSource Training Ralf Spenneberg     http://www.os-t.de
Am Bahnhof 3-5                          48565 Steinfurt         Germany
Fon: +49(0)2552 638 755                 Fax: +49(0)2552 638 757
