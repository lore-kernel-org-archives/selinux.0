Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KE1UWt019915
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 10:01:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KE1SmT007009
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 14:01:29 GMT
Message-ID: <3F93EAB3.7080109@redhat.com>
Date: Mon, 20 Oct 2003 10:01:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Carlos Anisio Monteiro <monteiro@ipen.br>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   selinux@tycho.nsa.gov
Subject: Re: process context
References: <3F8EEA16.8090908@ipen.br> <1066392235.31764.6.camel@moss-spartans.epoch.ncsc.mil> <3F93BEEF.9060904@ipen.br>
In-Reply-To: <3F93BEEF.9060904@ipen.br>
Content-Type: multipart/alternative;
 boundary="------------070808050803000003020206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070808050803000003020206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Carlos Anisio Monteiro wrote:

> Stephen Smalley wrote:
>
>>On Thu, 2003-10-16 at 14:57, Carlos Anisio Monteiro wrote:
>>  
>>
>>>Hi.
>>>
>>>The system have many process running in the following context:
>>>system_u:system_r:kernel_t (see example below).
>>>    
>>>
>><snip>
>>  
>>
>>>This is happen in the time of boot.
>>>
>>>Is this correct? Any process, p.ex. init, syslogd, klogd, shouldn't
>>>they running in the proper context?
>>>P.ex.: 
>>>init - system_u:system_r:init_t
>>>klogd - system_u:system_r:klogd_t
>>>cron - system_u:system_r:cron_t
>>>
>>>If yes. How I resolve ???
>>>    
>>>
>>
>>The possible scenarios are:
>>1) You never labeled /sbin/init with system_u:object_r:init_exec_t.
>>Based on your prior email, you have labeled /sbin/init, so this is not
>>the cause.
>>
>>2) You labeled /sbin/init initially, but you are running prelink on your
>>system and do not have the patched prelink program, so prelink is
>>cheerfully unlinking it and re-creating it with the default type,
>>causing it to fall back into sbin_t.  You can check for this by doing a
>>'ls --context /sbin/init' again.  Dan Walsh has a patched prelink
>>program that preserves security contexts available from his site,
>>ftp://people.redhat.com/dwalsh/SELinux.  prelink is enabled by default
>>in Fedora Core.
>>
>>3) /sbin/init is labeled correctly, but the policy is not loaded prior
>>to starting it, so the domain transition rule isn't defined when the
>>execution occurs.  This would happen if you failed to load the policy
>>from an initrd prior to execution of /sbin/init, or if you are trying to
>>perform the initial policy load via /sbin/init itself without
>>re-exec'ing it after performing the load.
>>
>>  
>>
> I loaded the policy in the initrd image and the boot process and the 
> contexts are fine. The policies must be loaded prior to init process.
> *I am much obliged to you*.
>
> However, alway that I change one policy I have to update the policies 
> in the initrd image. Or, can I load the minimum of policies in the 
> initrd image  and the remainder as script in the /etc/init.d 
> directory? So, the update to policies in initrd image should be very 
> little.
>
> Again, thanks! Thanks!

Currently that is what we are suggesting.  Modify mkinitrd with minimal 
policy and then have the initscripts load the on disk policy as early as 
possible.   We are working to the point where init itself will load 
policy and modification of the initrd will go away.

Dan

>
>-- 
>Carlos Anisio Monteiro  <monteiro@ipen.br>
>IPEN/CNEN-SP
>Sao Paulo - Brasil
>  
>
>

--------------070808050803000003020206
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Carlos Anisio Monteiro wrote:<br>
<blockquote type="cite" cite="mid3F93BEEF.9060904@ipen.br">
  <title></title>
Stephen Smalley wrote:<br>
  <blockquote
 cite="mid1066392235.31764.6.camel@moss-spartans.epoch.ncsc.mil"
 type="cite">
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
<a href="ftp://people.redhat.com/dwalsh/SELinux"
 class="moz-txt-link-freetext">ftp://people.redhat.com/dwalsh/SELinux</a>.  prelink is enabled by default
in Fedora Core.

3) /sbin/init is labeled correctly, but the policy is not loaded prior
to starting it, so the domain transition rule isn't defined when the
execution occurs.  This would happen if you failed to load the policy
from an initrd prior to execution of /sbin/init, or if you are trying to
perform the initial policy load via /sbin/init itself without
re-exec'ing it after performing the load.

  </pre>
  </blockquote>
I loaded the policy in the initrd image and the boot process and the
contexts
are fine. The policies must be loaded prior to init process.<br>
  <b>I am much obliged to you</b>.<br>
  <br>
However, alway that I change one policy I have to update the policies
in
the initrd image. Or, can I load the minimum of policies in the initrd
image&nbsp;
and the remainder as script in the /etc/init.d directory? So, the
update
to policies in initrd image should be very little.<br>
  <br>
Again, thanks! Thanks!<br>
</blockquote>
Currently that is what we are suggesting.&nbsp; Modify mkinitrd with minimal
policy and then have the initscripts load the on disk policy as early
as possible.&nbsp;&nbsp; We are working to the point where init itself will load
policy and modification of the initrd will go away.<br>
<br>
Dan<br>
<blockquote type="cite" cite="mid3F93BEEF.9060904@ipen.br"><br>
  <pre cols="$mailwrapcol" class="moz-signature">-- 
Carlos Anisio Monteiro  <a href="mailto:monteiro@ipen.br"
 class="moz-txt-link-rfc2396E">&lt;monteiro@ipen.br&gt;</a>
IPEN/CNEN-SP
Sao Paulo - Brasil
  </pre>
  <br>
</blockquote>
</body>
</html>

--------------070808050803000003020206--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
