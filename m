In-Reply-To: <20100508075904.GB3075@localhost.localdomain>
References: <OF4B777D47.6A3F031D-ON8525771C.00694668-8525771C.0070353C@vpcl.on.ca> <20100508075904.GB3075@localhost.localdomain>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Selinux and Apache in chroot question....
Message-ID: <OFF8CFA4DF.E6184554-ON8525771F.0048E817-85257720.006830B7@vpcl.on.ca>
From: fred.schnittke@vpcl.on.ca
Date: Tue, 11 May 2010 14:57:48 -0400
Content-Type: multipart/alternative; boundary="=_alternative 006830B585257720_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 006830B585257720_=
Content-Type: text/plain; charset="US-ASCII"

Hi:

Mr. Walsh and Mr. Grift have replied to some of my earlier questions 
regarding SELinux and Apache on a RedHat server, thank-you very much. 
However, I'm still not able to get things up and running. Here's a little 
history on what I've been trying to do:

I've been following the documentation in the NSA's "Guide to the Secure 
Configuration of Red Hat Enterprise Linux 5". There they do mention that 
you should chroot apache. We are also using MySQL and PHP and their 
documentation does not mention anything about chrooting mysql, and to be 
honest, I just could not get the RedHat pre-compiled version of MySQL to 
chroot, adn work with the chroot'd Apache. So I took it upon myself to 
remove the pre-compiled rpm packages for Apache, MySQL, and PHP, in favor 
of downloading and compiling those packages myself and running them in the 
chroot's

That worked out ok, but now to enable SELinux (and I did try your 
recommendations Daniel). it seems you have to go through each of the 
directories, sub-directories and files in the chroots, and set the context 
to match that of those in a typical RedHat install:

drwxr-xr-x  root root system_u:object_r:device_t:s0    /chroot/dev
drwxr-xr-x  root root system_u:object_r:tmp_t:s0       /chroot/etc
drwxr-xr-x  root root system_u:object_r:lib_t:s0       /chroot/lib
drwxr-xr-x  root root system_u:object_r:tmp_t:s0       /chroot/tmp
drwxr-xr-x  root root system_u:object_r:usr_t:s0       /chroot/usr
drwxr-xr-x  root root system_u:object_r:var_t:s0       /chroot/var
and the list goes on.....

I did that for every file, directory, etc, using chcon, then added the 
contexts to SELinux with semanage.

That's fine and dandy. But now when the server reboots Apache doesn't 
start. I can start it manually by running "service httpd start" (which is 
a modified file for the chroot environment), but it runs httpd unconfined. 
So I fooled around with: "run_init /etc/init.d/httpd start", but that asks 
me for my password, then gives me an error message:

usr/local/www/bin/httpd: error while loading shared libraries: 
libssl.so.6: cannot open shared object file: Permission denied

So, has anyone actually run Apache, MySQL, and PHP in chrooted jails in 
conjunction with SELinux?

I thought I was just following the recommendations in the NSA guide, but 
man it sure is tough.....



Thanks,


Fred Schnittke
--=_alternative 006830B585257720_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="Arial">Hi:</font>
<br>
<br><font size=2 face="Arial">Mr. Walsh and Mr. Grift have replied to some
of my earlier questions regarding SELinux and Apache on a RedHat server,
thank-you very much. However, I'm still not able to get things up and running.
Here's a little history on what I've been trying to do:</font>
<br>
<br><font size=2 face="Arial">I've been following the documentation in
the NSA's &quot;Guide to the Secure Configuration of Red Hat Enterprise
Linux 5&quot;. There they do mention that you should chroot apache. We
are also using MySQL and PHP and their documentation does not mention anything
about chrooting mysql, and to be honest, I just could not get the RedHat
pre-compiled version of MySQL to chroot, adn work with the chroot'd Apache.
So I took it upon myself to remove the pre-compiled rpm packages for Apache,
MySQL, and PHP, in favor of downloading and compiling those packages myself
and running them in the chroot's</font>
<br>
<br><font size=2 face="Arial">That worked out ok, but now to enable SELinux
(and I did try your recommendations Daniel). it seems you have to go through
each of the directories, sub-directories and files in the chroots, and
set the context to match that of those in a typical RedHat install:</font>
<br>
<br><font size=2 face="Courier 10 Pitch">drwxr-xr-x &nbsp;root root system_u:object_r:device_t:s0
&nbsp; &nbsp;/chroot/dev</font>
<br><font size=2 face="Courier 10 Pitch">drwxr-xr-x &nbsp;root root system_u:object_r:tmp_t:s0
&nbsp; &nbsp; &nbsp; /chroot/etc</font>
<br><font size=2 face="Courier 10 Pitch">drwxr-xr-x &nbsp;root root system_u:object_r:lib_t:s0
&nbsp; &nbsp; &nbsp; /chroot/lib</font>
<br><font size=2 face="Courier 10 Pitch">drwxr-xr-x &nbsp;root root system_u:object_r:tmp_t:s0
&nbsp; &nbsp; &nbsp; /chroot/tmp</font>
<br><font size=2 face="Courier 10 Pitch">drwxr-xr-x &nbsp;root root system_u:object_r:usr_t:s0
&nbsp; &nbsp; &nbsp; /chroot/usr</font>
<br><font size=2 face="Courier 10 Pitch">drwxr-xr-x &nbsp;root root system_u:object_r:var_t:s0
&nbsp; &nbsp; &nbsp; /chroot/var</font>
<br><font size=2 face="Courier 10 Pitch">and the list goes on.....</font>
<br>
<br><font size=2 face="Arial">I did that for every file, directory, etc,
using chcon, then added the contexts to SELinux with semanage.</font>
<br>
<br><font size=2 face="Arial">That's fine and dandy. But now when the server
reboots Apache doesn't start. I can start it manually by running &quot;service
httpd start&quot; (which is a modified file for the chroot environment),
but it runs httpd unconfined. So I fooled around with: &quot;run_init /etc/init.d/httpd
start&quot;, but that asks me for my password, then gives me an error message:</font>
<br>
<br><font size=2 face="Courier 10 Pitch">usr/local/www/bin/httpd: error
while loading shared libraries: libssl.so.6: cannot open shared object
file: Permission denied</font>
<br>
<br><font size=2 face="Arial">So, has anyone actually run Apache, MySQL,
and PHP in chrooted jails in conjunction with SELinux?</font>
<br>
<br><font size=2 face="Arial">I thought I was just following the recommendations
in the NSA guide, but man it sure is tough.....</font>
<br>
<br>
<br>
<br><font size=2 face="Arial">Thanks,</font>
<br>
<br>
<br><font size=2 face="Arial">Fred Schnittke</font>
--=_alternative 006830B585257720_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
