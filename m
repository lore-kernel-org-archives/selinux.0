Message-ID: <490F00E1.4050704@rubix.com>
Date: Mon, 03 Nov 2008 14:47:13 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: Label Translation on Fedora 9
References: <490EE548.60400@rubix.com> <1225718978.3609.3.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1225718978.3609.3.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------030509010202060807080202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030509010202060807080202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Stephen Smalley wrote:
> On Mon, 2008-11-03 at 12:49 +0100, Andy Warner wrote:
>   
>> I am running Fedora 9 with the MLS policy and see no evidence that the
>> label translation is enabled. I am using the default setrans.conf and
>> the "disable=1" flag is commented out.
>>
>> Using the selinux_trans_to_raw (e.g., with a SystemHigh level)
>> produces the exact same label string as passed in which will not pass
>> validation (using s15:c0.c1023 will pass validation). 
>>
>> Trying id-Z followed by newrole produces:
>> id -Z
>> warner_u:secadm_r:secadm_t:s0-s15:c0.c1023
>>
>> newrole -l SystemLow-SystemHigh
>> warner_u:secadm_r:secadm_t:SystemLow-SystemHigh is not a valid context
>>
>> Is there something that must be done to activate label translation?
>>     
>
> Label translation is provided by a daemon, mcstrans.
>
> yum install mcstrans
> /sbin/chkconfig mcstrans on
> /sbin/service mcstrans start
>   

Thanks. I was not starting the mcstrans service. When I get a 
translation, it seems odd as follows.

without mcstrans:
id -Z
warner_u:secadm_r:secadm_t:s0-s15:c0.c1023

with mcstrans:
id -Z
warner_u:secadm_r:secadm_t:SystemLow:SystemLow-SystemHigh

Is it expected to have the high end of the range expressed as a range? 
The translation table has the following relevant entries:
s0                             SystemLow
s0-s15:c0.c1023      SystemLow-SystemHigh



--------------030509010202060807080202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Stephen Smalley wrote:
<blockquote
 cite="mid:1225718978.3609.3.camel@moss-spartans.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">On Mon, 2008-11-03 at 12:49 +0100, Andy Warner wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am running Fedora 9 with the MLS policy and see no evidence that the
label translation is enabled. I am using the default setrans.conf and
the "disable=1" flag is commented out.

Using the selinux_trans_to_raw (e.g., with a SystemHigh level)
produces the exact same label string as passed in which will not pass
validation (using s15:c0.c1023 will pass validation). 

Trying id-Z followed by newrole produces:
id -Z
warner_u:secadm_r:secadm_t:s0-s15:c0.c1023

newrole -l SystemLow-SystemHigh
warner_u:secadm_r:secadm_t:SystemLow-SystemHigh is not a valid context

Is there something that must be done to activate label translation?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Label translation is provided by a daemon, mcstrans.

yum install mcstrans
/sbin/chkconfig mcstrans on
/sbin/service mcstrans start
  </pre>
</blockquote>
<br>
Thanks. I was not starting the mcstrans service. When I get a
translation, it seems odd as follows.<br>
<br>
without mcstrans:<br>
id -Z<br>
warner_u:secadm_r:secadm_t:s0-s15:c0.c1023<br>
<br>
with mcstrans:<br>
id -Z<br>
warner_u:secadm_r:secadm_t:SystemLow:SystemLow-SystemHigh<br>
<br>
Is it expected to have the high end of the range expressed as a range?
The translation table has the following relevant entries:<br>
s0&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; SystemLow<br>
s0-s15:c0.c1023&nbsp;&nbsp; &nbsp;&nbsp; SystemLow-SystemHigh<br>
<br>
<br>
</body>
</html>

--------------030509010202060807080202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
