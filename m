Message-ID: <4A4CBDB0.8040001@redhat.com>
Date: Thu, 02 Jul 2009 10:01:20 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [Patch 0/2] libsemanage: remember and retrieve dontaudit settings
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com>  <4A4C168C.2040900@redhat.com> <1246538026.13464.262.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246538026.13464.262.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------050005090406090105060607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050005090406090105060607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2009 08:33 AM, Stephen Smalley wrote:
> On Wed, 2009-07-01 at 22:08 -0400, Christopher Pardy wrote:
>    
>> This is a heavily modified version of the patch I recently submitted. It
>> provides 3 new functions: in libsepol sepol_get_disable_dontaudit; in
>> libsemanage semanage_get_disable_dontaudit; in libselinux
>> is_dontaudit_disabled. It also fixes issues with the previous patch.
>>
>> The justification for this patch is the same as the one I posted
>> earlier. Simply, there is currently no way to know if dontaudit rules
>> are  enabled. Additionally once don't audit rules are turned they turn
>> themselves off after policy rebuild (is that the desired functionality?)
>>      
>
> semodule -DB should still strip dontaudit rules from the policy, and
> semodule -B should still restore them.  The only thing that should
> change IIUC is that semodule -DB should persist across any other
> semodule or semanage operations other than semodule -B.
>
>    
See Dan Walsh's patch to policycoreutils for this functionality. I need 
the functionality I'm creating with this persistence in some gui work 
I'm doing and I believe it's much more intuitive if things stay turned 
off till they're turned back on.
>> This patch provides  a way to check on both the current and pending
>> state of the dontaudit rules and it maintains this state between policy
>> rebuilds.
>>
>> Signed-off-by Christopher Pardy<cpardy@redhat.com>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>      


--------------050005090406090105060607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 07/02/2009 08:33 AM, Stephen Smalley wrote:
<blockquote
 cite="mid:1246538026.13464.262.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">On Wed, 2009-07-01 at 22:08 -0400, Christopher Pardy wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">This is a heavily modified version of the patch I recently submitted. It 
provides 3 new functions: in libsepol sepol_get_disable_dontaudit; in 
libsemanage semanage_get_disable_dontaudit; in libselinux 
is_dontaudit_disabled. It also fixes issues with the previous patch.

The justification for this patch is the same as the one I posted 
earlier. Simply, there is currently no way to know if dontaudit rules 
are  enabled. Additionally once don't audit rules are turned they turn 
themselves off after policy rebuild (is that the desired functionality?) 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
semodule -DB should still strip dontaudit rules from the policy, and
semodule -B should still restore them.  The only thing that should
change IIUC is that semodule -DB should persist across any other
semodule or semanage operations other than semodule -B.

  </pre>
</blockquote>
See Dan Walsh's patch to policycoreutils for this functionality. I need
the functionality I'm creating with this persistence in some gui work
I'm doing and I believe it's much more intuitive if things stay turned
off till they're turned back on.<br>
<blockquote
 cite="mid:1246538026.13464.262.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">This patch provides  a way to check on both the current and pending 
state of the dontaudit rules and it maintains this state between policy 
rebuilds.

Signed-off-by Christopher Pardy <a class="moz-txt-link-rfc2396E" href="mailto:cpardy@redhat.com">&lt;cpardy@redhat.com&gt;</a>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with
the words "unsubscribe selinux" without quotes as the message.
    </pre>
  </blockquote>
</blockquote>
<br>
</body>
</html>

--------------050005090406090105060607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
