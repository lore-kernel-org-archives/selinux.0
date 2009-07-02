Message-ID: <4A4CC469.3050805@redhat.com>
Date: Thu, 02 Jul 2009 10:30:01 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [Patch 2/2] libsemanage: remember and retrieve dontaudit settings
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com> <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------070801070602000904090909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070801070602000904090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2009 10:13 AM, Stephen Smalley wrote:
> On Thu, 2009-07-02 at 09:55 -0400, Christopher Pardy wrote:
>    
>> It's not that a program would use this that couldn't link against
>> libsemanage the functionality just seemed closer to that of the
>> functions in libselinux, I've been doing alot of work on fedora stuff
>> It seems to me  that 90% of the code in libsemanage is handle
>> dependent functions. libselinux seems to be more of a global setting
>> kind of deal. so it made sense to put it here. Let me know if this
>> isn't the case
>>      
>
> Unless you envision this interface being called by non-management
> programs, I think it is reasonable to require them to link against
> libsemanage and use an interface provided by it.
>
>    
If I'm not mistaken disabling dontaudit rules will cause more AVCs, if 
this is the case then programs like SETroubleshoot would want to know if 
dontaudit rules are turned on. Additionally see my previous explaination 
as to why the two are separated.
>>> This doesn't make sense to me - we check whether we've already set
>>> disable dontaudit and use that to decide whether to create the file?
>>> But the existence of the file is what would have triggered setting
>>> disable dontaudit in the first place.  Round and round we go...
>>>
>>>        
>> When we create the handle we set it's default property to the system
>> default. When we commit a handle we set the system default property to
>> the handles property. In between it is fully possible to that we have
>> called a set_disable_dontaudit to change the value in the handle. If
>> you would rather I checked if the two were different first I can.
>>      
>
> Hmmm...but if the flag file is private to the store, then you can just
> create or remove it directly from semanage_set_disable_dontaudit(), and
> you won't need to do this at commit.  At which point you seemingly don't
> need the libsepol or libsemanage get functions.
>
>    
If the flag file was created at time of semanage_set_disable_dontaudit() 
it would reflect a pending state and not an actual state, if for some 
reason commit was never called or simply failed it would incorrectly 
reflect the state of the system. By creating the file only after a 
successful commit the file correctly identifies our actual state. While 
the get functions correctly identify our pending state.
> BTW, to create a new file in the store, you'll want to extend
> semanage_sandbox_defs in semanage_store.h with a
> SEMANAGE_DISABLE_DONTAUDIT value and use
> semanage_fname(SEMANAGE_DISABLE_DONTAUDIT) to obtain the pathname to the
> flag file.
>
>    
Thanks for that, I'll get a new version of the patch out shortly.

--------------070801070602000904090909
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 07/02/2009 10:13 AM, Stephen Smalley wrote:
<blockquote
 cite="mid:1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">On Thu, 2009-07-02 at 09:55 -0400, Christopher Pardy wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">It's not that a program would use this that couldn't link against
libsemanage the functionality just seemed closer to that of the
functions in libselinux, I've been doing alot of work on fedora stuff
It seems to me  that 90% of the code in libsemanage is handle
dependent functions. libselinux seems to be more of a global setting
kind of deal. so it made sense to put it here. Let me know if this
isn't the case
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Unless you envision this interface being called by non-management
programs, I think it is reasonable to require them to link against
libsemanage and use an interface provided by it.

  </pre>
</blockquote>
If I'm not mistaken disabling dontaudit rules will cause more AVCs, if
this is the case then programs like SETroubleshoot would want to know
if dontaudit rules are turned on. Additionally see my previous
explaination as to why the two are separated.<br>
<blockquote
 cite="mid:1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">This doesn't make sense to me - we check whether we've already set
disable dontaudit and use that to decide whether to create the file?
But the existence of the file is what would have triggered setting
disable dontaudit in the first place.  Round and round we go...
  
      </pre>
    </blockquote>
    <pre wrap="">When we create the handle we set it's default property to the system
default. When we commit a handle we set the system default property to
the handles property. In between it is fully possible to that we have
called a set_disable_dontaudit to change the value in the handle. If
you would rather I checked if the two were different first I can.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Hmmm...but if the flag file is private to the store, then you can just
create or remove it directly from semanage_set_disable_dontaudit(), and
you won't need to do this at commit.  At which point you seemingly don't
need the libsepol or libsemanage get functions.

  </pre>
</blockquote>
If the flag file was created at time of
semanage_set_disable_dontaudit() it would reflect a pending state and
not an actual state, if for some reason commit was never called or
simply failed it would incorrectly reflect the state of the system. By
creating the file only after a successful commit the file correctly
identifies our actual state. While the get functions correctly identify
our pending state.<br>
<blockquote
 cite="mid:1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">BTW, to create a new file in the store, you'll want to extend
semanage_sandbox_defs in semanage_store.h with a
SEMANAGE_DISABLE_DONTAUDIT value and use
semanage_fname(SEMANAGE_DISABLE_DONTAUDIT) to obtain the pathname to the
flag file.

  </pre>
</blockquote>
Thanks for that, I'll get a new version of the patch out shortly.<br>
</body>
</html>

--------------070801070602000904090909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
