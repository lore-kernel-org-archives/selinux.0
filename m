Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KDuMWt019873
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 09:56:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KDuA0p028770
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:56:10 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
	by jazzswing.ncsc.mil  with ESMTP id h9KDtwr9028756
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:56:09 GMT
Message-ID: <3F93BEEF.9060904@ipen.br>
Date: Mon, 20 Oct 2003 08:54:39 -0200
From: Carlos Anisio Monteiro <monteiro@ipen.br>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   Russell Coker
 <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: process context
References: <3F8EEA16.8090908@ipen.br> <1066392235.31764.6.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------070507020900000003060400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------070507020900000003060400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Thu, 2003-10-16 at 14:57, Carlos Anisio Monteiro wrote:
>  
>
>>Hi.
>>
>>The system have many process running in the following context:
>>system_u:system_r:kernel_t (see example below).
>>    
>>
><snip>
>  
>
>>This is happen in the time of boot.
>>
>>Is this correct? Any process, p.ex. init, syslogd, klogd, shouldn't
>>they running in the proper context?
>>P.ex.: 
>>init - system_u:system_r:init_t
>>klogd - system_u:system_r:klogd_t
>>cron - system_u:system_r:cron_t
>>
>>If yes. How I resolve ???
>>    
>>
>
>The possible scenarios are:
>1) You never labeled /sbin/init with system_u:object_r:init_exec_t.
>Based on your prior email, you have labeled /sbin/init, so this is not
>the cause.
>
>2) You labeled /sbin/init initially, but you are running prelink on your
>system and do not have the patched prelink program, so prelink is
>cheerfully unlinking it and re-creating it with the default type,
>causing it to fall back into sbin_t.  You can check for this by doing a
>'ls --context /sbin/init' again.  Dan Walsh has a patched prelink
>program that preserves security contexts available from his site,
>ftp://people.redhat.com/dwalsh/SELinux.  prelink is enabled by default
>in Fedora Core.
>
>3) /sbin/init is labeled correctly, but the policy is not loaded prior
>to starting it, so the domain transition rule isn't defined when the
>execution occurs.  This would happen if you failed to load the policy
>from an initrd prior to execution of /sbin/init, or if you are trying to
>perform the initial policy load via /sbin/init itself without
>re-exec'ing it after performing the load.
>
>  
>
I loaded the policy in the initrd image and the boot process and the 
contexts are fine. The policies must be loaded prior to init process.
*I am much obliged to you*.

However, alway that I change one policy I have to update the policies in 
the initrd image. Or, can I load the minimum of policies in the initrd 
image  and the remainder as script in the /etc/init.d directory? So, the 
update to policies in initrd image should be very little.

Again, thanks! Thanks!

-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil



--------------070507020900000003060400
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title></title>
</head>
<body>
Stephen Smalley wrote:<br>
<blockquote type="cite"
 cite="mid1066392235.31764.6.camel@moss-spartans.epoch.ncsc.mil">
  <pre wrap="">On Thu, 2003-10-16 at 14:57, Carlos Anisio Monteiro wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi.

The system have many process running in the following context:
system_u:system_r:kernel_t (see example below).
    </pre>
  </blockquote>
  <pre wrap=""><!---->&lt;snip&gt;
  </pre>
  <blockquote type="cite">
    <pre wrap="">This is happen in the time of boot.

Is this correct? Any process, p.ex. init, syslogd, klogd, shouldn't
they running in the proper context?
P.ex.: 
init - system_u:system_r:init_t
klogd - system_u:system_r:klogd_t
cron - system_u:system_r:cron_t

If yes. How I resolve ???
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The possible scenarios are:
1) You never labeled /sbin/init with system_u:object_r:init_exec_t.
Based on your prior email, you have labeled /sbin/init, so this is not
the cause.

2) You labeled /sbin/init initially, but you are running prelink on your
system and do not have the patched prelink program, so prelink is
cheerfully unlinking it and re-creating it with the default type,
causing it to fall back into sbin_t.  You can check for this by doing a
'ls --context /sbin/init' again.  Dan Walsh has a patched prelink
program that preserves security contexts available from his site,
<a class="moz-txt-link-freetext" href="ftp://people.redhat.com/dwalsh/SELinux">ftp://people.redhat.com/dwalsh/SELinux</a>.  prelink is enabled by default
in Fedora Core.

3) /sbin/init is labeled correctly, but the policy is not loaded prior
to starting it, so the domain transition rule isn't defined when the
execution occurs.  This would happen if you failed to load the policy
from an initrd prior to execution of /sbin/init, or if you are trying to
perform the initial policy load via /sbin/init itself without
re-exec'ing it after performing the load.

  </pre>
</blockquote>
I loaded the policy in the initrd image and the boot process and the contexts
are fine. The policies must be loaded prior to init process.<br>
<b>I am much obliged to you</b>.<br>
<br>
However, alway that I change one policy I have to update the policies in
the initrd image. Or, can I load the minimum of policies in the initrd image&nbsp;
and the remainder as script in the /etc/init.d directory? So, the update
to policies in initrd image should be very little.<br>
<br>
Again, thanks! Thanks!<br>
<br>
<pre class="moz-signature" cols="$mailwrapcol">-- 
Carlos Anisio Monteiro  <a class="moz-txt-link-rfc2396E" href="mailto:monteiro@ipen.br">&lt;monteiro@ipen.br&gt;</a>
IPEN/CNEN-SP
Sao Paulo - Brasil
</pre>
<br>
</body>
</html>

--------------070507020900000003060400--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
