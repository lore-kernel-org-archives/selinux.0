Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0Q8aAnb028814
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 03:36:15 -0500
Received: from collab.rosalab.ru (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0Q8a923023793
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 08:36:09 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by collab.rosalab.ru (Postfix) with ESMTP id 1881229C1BE
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 12:36:06 +0400 (MSK)
Received: from collab.rosalab.ru ([127.0.0.1])
	by localhost (collab.rosalab.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBVFqfjt-Cwb for <selinux@tycho.nsa.gov>;
	Thu, 26 Jan 2012 12:36:05 +0400 (MSK)
Received: from localhost.localdomain (unknown [192.168.20.123])
	by collab.rosalab.ru (Postfix) with ESMTPSA id 50C6829C1BB
	for <selinux@tycho.nsa.gov>; Thu, 26 Jan 2012 12:36:05 +0400 (MSK)
Message-ID: <4F2110C5.5060100@rosalab.ru>
Date: Thu, 26 Jan 2012 12:37:25 +0400
From: Budanov Eugene <eugene.budanov@rosalab.ru>
MIME-Version: 1.0
To: SELinux Upstream <selinux@tycho.nsa.gov>
Subject: Compiler cannot find ruby.h
Content-Type: multipart/alternative;
 boundary="------------070401040009070205010600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070401040009070205010600
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all!

I'm trying to build libselinux-2.1.9-2.fc17.src.rpm from FC17.

But the compilation causes of an error type:

../include/selinux/selinux.h:348: Warning 451: Setting a const char * 
variable may leak memory.
cc -g -O2 -Wa,--compress-debug-sections -gdwarf-4 
-fvar-tracking-assignments -frecord-gcc-switches -Wstrict-aliasing=2 
-pipe -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 
-fstack-protector --param=ssp-buffer-size=4 -fPIC -I../include 
-I/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
-I/usr/lib64/ruby/1.8/x86_64-linux -fPIC -DSHARED -c -o 
selinuxswig_ruby_wrap.lo selinuxswig_ruby_wrap.c
selinuxswig_ruby_wrap.c:832:18: fatal error: ruby.h: No such file or 
directory
compilation terminated.
make[1]: *** [selinuxswig_ruby_wrap.lo] Error 1
make[1]: Leaving directory `/root/rpmbuild/BUILD/libselinux-2.1.9/src'
make: *** [rubywrap] Error 2

File ruby.h into ../include/selinux/ directory really absent.

----
Best regards,
Budanov Eugene ROSA Lab.
Russia, Moscow.
e-mail : eugene.budanov@rosalab.ru
phone +79160674716 (UTC +4)

--------------070401040009070205010600
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi all!<br>
    <br>
    I'm trying to build libselinux-2.1.9-2.fc17.src.rpm from FC17.<br>
    <br>
    <div id="gt-res-c" class="g-unit">
      <div id="gt-res-p">
        <div id="gt-res-data">
          <div id="gt-res-wrap">
            <div id="gt-res-content" class="almost_half_cell">
              <div dir="ltr" style="zoom:1"><span id="result_box"
                  class="short_text" lang="en"><span class="hps">But the</span>
                  <span class="hps">compilation causes of</span> <span
                    class="hps">an error</span> <span class="hps">type</span>:<br>
                  <br>
                  <span class="hps"></span></span></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    ../include/selinux/selinux.h:348: Warning 451: Setting a const char
    * variable may leak memory.<br>
    cc -g -O2 -Wa,--compress-debug-sections -gdwarf-4
    -fvar-tracking-assignments -frecord-gcc-switches -Wstrict-aliasing=2
    -pipe -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2
    -fstack-protector --param=ssp-buffer-size=4 -fPIC -I../include
    -I/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
    -I/usr/lib64/ruby/1.8/x86_64-linux -fPIC -DSHARED -c -o
    selinuxswig_ruby_wrap.lo selinuxswig_ruby_wrap.c<br>
    selinuxswig_ruby_wrap.c:832:18: fatal error: ruby.h: No such file or
    directory<br>
    compilation terminated.<br>
    make[1]: *** [selinuxswig_ruby_wrap.lo] Error 1<br>
    make[1]: Leaving directory
    `/root/rpmbuild/BUILD/libselinux-2.1.9/src'<br>
    make: *** [rubywrap] Error 2<br>
    <br>
    File ruby.h into ../include/selinux/ directory really absent. <br>
    <br>
    ----<br>
    Best regards,
    <br>
    Budanov Eugene
    ROSA Lab.
    <br>
    Russia, Moscow.
    <br>
    e-mail : <a class="moz-txt-link-abbreviated"
      href="mailto:eugene.budanov@rosalab.ru">eugene.budanov@rosalab.ru</a>
    <br>
    phone +79160674716
    (UTC +4)<br>
  </body>
</html>

--------------070401040009070205010600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
