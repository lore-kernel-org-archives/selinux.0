Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9CEWFkK013906
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2010 10:32:18 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9CEWH64000508
	for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2010 14:32:17 GMT
Received: by pxi15 with SMTP id 15so443889pxi.12
        for <selinux@tycho.nsa.gov>; Tue, 12 Oct 2010 07:32:16 -0700 (PDT)
Message-ID: <4CB47175.6020302@gmail.com>
Date: Tue, 12 Oct 2010 07:32:21 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
Subject: Re: ERROR 'syntax error' at token ':c' on line 42:
References: <AANLkTimEezzq9XqJSpO3B4LY3NWQLiD2CN-0Z4Wd764U@mail.gmail.com> <AANLkTi=RFa1UkhfHuq_dUUYaNaPD1yWnDwRQ+wZ8p-C_@mail.gmail.com>
In-Reply-To: <AANLkTi=RFa1UkhfHuq_dUUYaNaPD1yWnDwRQ+wZ8p-C_@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------090400070909060002030308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090400070909060002030308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  On 10/12/2010 04:39 AM, Stephen Smalley wrote:
> Looks like the previously discussed flex bug, e.g.:
> http://marc.info/?l=selinux&m=126763385807985&w=2
>

yeah I was thinking this as well.. from what it seems this is hitting 
with the
packages provided by suse,  as well as the userspace packages. but unlike
my other system that was hitting this, the error is with building a 
module, instead of building
the policy.(as a workaround I would throw in an older version of flex, 
then build only
checkpolicy/module to get it working..(or if I was too lazy just copy a 
version that
works over to the other machine)).

I can go through this today and see what I get.. one thing I noticed 
with the packages
from suse(11.4) is, policycoreutils is older than same of the newer 
packages they have,
causing other errors with python i.e. seinfo not found kind of error.

As for flex itself.. I do remember starting a bisect on that package, 
but then realized
that from version 2.34(if I remember correctly) to 2.35 theirs just a 
few patches that
are rather lengthy, making a bisect possible, but then going through the 
bad commit
more lengthy...

Justin P. Mattock



--------------090400070909060002030308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    On 10/12/2010 04:39 AM, Stephen Smalley wrote:
    <blockquote
      cite="mid:AANLkTi=RFa1UkhfHuq_dUUYaNaPD1yWnDwRQ+wZ8p-C_@mail.gmail.com"
      type="cite">
      <pre wrap="">Looks like the previously discussed flex bug, e.g.:
<a class="moz-txt-link-freetext" href="http://marc.info/?l=selinux&amp;m=126763385807985&amp;w=2">http://marc.info/?l=selinux&amp;m=126763385807985&amp;w=2</a>

</pre>
    </blockquote>
    <br>
    <small>yeah I was thinking this as well.. from what it seems this is
      hitting with the<br>
      packages provided by suse,&nbsp; as well as the userspace packages. but
      unlike<br>
      my other system that was hitting this, the error is with building
      a module, instead of building<br>
      the policy.(as a workaround I would throw in an older version of
      flex, then build only<br>
      checkpolicy/module to get it working..(or if I was too lazy just
      copy a version that<br>
      works over to the other machine)).<br>
      <br>
      I can go through this today and see what I get.. one thing I
      noticed with the packages<br>
      from suse(11.4) is, policycoreutils is older than same of the
      newer packages they have,<br>
      causing other errors with python i.e. seinfo not found kind of
      error.<br>
      <br>
      As for flex itself.. I do remember starting a bisect on that
      package, but then realized<br>
      that from version 2.34(if I remember correctly) to 2.35 theirs
      just a few patches that<br>
      are rather lengthy, making a bisect possible, but then going
      through the bad commit<br>
      more lengthy...<br>
      <br>
      Justin P. Mattock<br>
      <br>
      <br>
    </small>
  </body>
</html>

--------------090400070909060002030308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
