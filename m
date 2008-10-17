Message-ID: <48F85ECC.108@rubix.com>
Date: Fri, 17 Oct 2008 11:45:48 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: adding objects classes and permissions to policy
References: <48F798BB.6070602@rubix.com>	 <1224186793.9247.139.camel@moss-spartans.epoch.ncsc.mil> <1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/alternative;
 boundary="------------040707060809000002040308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040707060809000002040308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Stephen Smalley wrote:
> On Thu, 2008-10-16 at 15:53 -0400, Stephen Smalley wrote:
>   
>> On Thu, 2008-10-16 at 21:40 +0200, Andy Warner wrote:
>>     
>>> When adding new object classes and permissions to SELinux policy is it
>>> necessary to re-create flask.h and av_permissions.h header files so
>>> that a user-space object manager can access the associated defines? If
>>> so, would someone give me some pointers as to how these are
>>> generated? 
>>>       
>> You should use the dynamic class/permission lookup facilities for any
>> new code.  man selinux_set_mapping
>>
>> XSELinux and SE-PostgreSQL are already using it I believe.
>>     
>
>   
I can't find any evidence that my version of libselinux contains the 
selinux_set_mapping function. I am using CentOS 5.1 with libselinux 
version 1.33.4. I have been learning RHEL 5 tends to be a bit behind the 
times with regards to SELinux functionality. Does libselinux 1.33.4 not 
have the dynamic class/permission lookup facilities? If it does not, any 
advice on how to add object classes / permissions to policy ? Moving to 
Fedora is a possibility, maybe it's worth considering as this would not 
be the first issue we have had with an outdated SELinux mechanism on 
RHEL 5 (?). We are integrating SELinux TE / MLS with our commercial 
DBMS, and I have learned that RHEL 5 does not have the database related 
object classes /permissions in the base policy where the most recent 
Fedora does, hence my need to add the object classes /permissions in RHEL 5.

> Example usage from XSELinux:
> http://marc.info/?l=selinux&m=118114723416269&w=2
>
>   

--------------040707060809000002040308
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Stephen Smalley wrote:
<blockquote
 cite="mid:1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">On Thu, 2008-10-16 at 15:53 -0400, Stephen Smalley wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Thu, 2008-10-16 at 21:40 +0200, Andy Warner wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">When adding new object classes and permissions to SELinux policy is it
necessary to re-create flask.h and av_permissions.h header files so
that a user-space object manager can access the associated defines? If
so, would someone give me some pointers as to how these are
generated? 
      </pre>
    </blockquote>
    <pre wrap="">You should use the dynamic class/permission lookup facilities for any
new code.  man selinux_set_mapping

XSELinux and SE-PostgreSQL are already using it I believe.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
I can't find any evidence that my version of libselinux contains the
selinux_set_mapping function. I am using CentOS 5.1 with libselinux
version 1.33.4. I have been learning RHEL 5 tends to be a bit behind
the times with regards to SELinux functionality. Does libselinux 1.33.4
not have the dynamic class/permission lookup facilities? If it does
not, any advice on how to add object classes / permissions to policy ?
Moving to Fedora is a possibility, maybe it's worth considering as this
would not be the first issue we have had with an outdated SELinux
mechanism on RHEL 5 (?). We are integrating SELinux TE / MLS with our
commercial DBMS, and I have learned that RHEL 5 does not have the
database related object classes /permissions in the base policy where
the most recent Fedora does, hence my need to add the object classes
/permissions in RHEL 5.<br>
<br>
<blockquote
 cite="mid:1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil"
 type="cite">
  <pre wrap="">Example usage from XSELinux:
<a class="moz-txt-link-freetext" href="http://marc.info/?l=selinux&m=118114723416269&w=2">http://marc.info/?l=selinux&amp;m=118114723416269&amp;w=2</a>

  </pre>
</blockquote>
</body>
</html>

--------------040707060809000002040308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
