Message-ID: <3F8E9DB7.5030903@redhat.com>
Date: Thu, 16 Oct 2003 09:31:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: [Fwd: Re: avc_toggle and avc_enforcing]
Content-Type: multipart/mixed;
 boundary="------------090302060106020307020007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090302060106020307020007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------090302060106020307020007
Content-Type: message/rfc822;
 name="Re: avc_toggle and avc_enforcing"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="Re: avc_toggle and avc_enforcing"

Message-ID: <3F8E9D94.5080909@redhat.com>
Date: Thu, 16 Oct 2003 09:31:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kerry Thompson <kerry@crypt.gen.nz>
Subject: Re: avc_toggle and avc_enforcing
References: <3F8BE8E5.9050006@ipen.br>    <1066145242.5054.213.camel@moss-spartans.epoch.ncsc.mil> <2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz>
In-Reply-To: <2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz>
Content-Type: multipart/alternative;
 boundary="------------000105070903010202000504"

This is a multi-part message in MIME format.
--------------000105070903010202000504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Kerry Thompson wrote:

>Speaking of which, I'd like to assemble a quick list of userland ( or more
>accurately, adminland ) changes between the current release and the
>previous non-/selinux release to update the documentation I've got, like
>the U-FAQ. The ones I've noticed so far :
>
>- avc_enforcing, avc_toggle replaced by /selinux/enforcing
>- id command requires -c to display context
>  
>
This has been converted to -Z in latest patches, for consistency.

>- ps command uses -Z to display context
>- initrd now mandatory
>  
>
We are working to remove this requirement.

>- selinux kernel boot option
>- multiple changes to installation procedure
>  
>
>- SRPMs added to installation image
>- new tools added ( Tresys tools, star )
>- binary RPMs available ( thanks Daniel )
>
>  
>
Your welcome.

>I've looked into the ChangeLog files, but there really isn't much info
>there, so I'd like to hear of any other changes that have been made which
>need to be documented.
>
>  
>
We are working to eliminate root assumptions in the OS and replace them 
with ones based on
security contexts.  So config tools should be prompting for your 
password instead of root password. 

One goal of userland changes is that the average user should not have to 
know that he is running
on a SELinux machine.  A system administrator should be able to manage 
the machine with limited knowlege of the way policy works.

>I'm still working on getting my test system up to the new 2.4 and 2.6,
>unfortunately I rendered it unbootable last night so it will take a little
>longer than expected ( note to self : make sure kernel can build an initrd
>before removing /boot/initrd* ).
>
>Kerry
>
>
>Stephen Smalley said:
>  
>
>>On Tue, 2003-10-14 at 08:15, Carlos Anísio Monteiro wrote:
>>    
>>
>>>Please, where I find the commands: avc_toggle and avc_enforcing. What
>>>are it the packages where it are?
>>>      
>>>
>>They no longer exist as programs.  With the new SELinux API, you can
>>simply 'cat /selinux/enforce' to see the current enforcing value,
>>'echo 1 > /selinux/enforce' to switch into enforcing mode, and
>>'echo  > /selinux/enforce' to switch into permissive mode (if permitted
>>by the policy).
>>
>>--
>>Stephen Smalley <sds@epoch.ncsc.mil>
>>National Security Agency
>>    
>>
>
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>

--------------000105070903010202000504
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Kerry Thompson wrote:<br>
<blockquote type="cite"
 cite="mid2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz">
  <pre wrap="">Speaking of which, I'd like to assemble a quick list of userland ( or more
accurately, adminland ) changes between the current release and the
previous non-/selinux release to update the documentation I've got, like
the U-FAQ. The ones I've noticed so far :

- avc_enforcing, avc_toggle replaced by /selinux/enforcing
- id command requires -c to display context
  </pre>
</blockquote>
This has been converted to -Z in latest patches, for consistency.<br>
<blockquote type="cite"
 cite="mid2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz">
  <pre wrap="">- ps command uses -Z to display context
- initrd now mandatory
  </pre>
</blockquote>
We are working to remove this requirement.<br>
<blockquote type="cite"
 cite="mid2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz">
  <pre wrap="">- selinux kernel boot option
- multiple changes to installation procedure
  </pre>
</blockquote>
<blockquote type="cite"
 cite="mid2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz">
  <pre wrap="">- SRPMs added to installation image
- new tools added ( Tresys tools, star )
- binary RPMs available ( thanks Daniel )

  </pre>
</blockquote>
Your welcome.<br>
<blockquote type="cite"
 cite="mid2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz">
  <pre wrap="">I've looked into the ChangeLog files, but there really isn't much info
there, so I'd like to hear of any other changes that have been made which
need to be documented.

  </pre>
</blockquote>
We are working to eliminate root assumptions in the OS and replace them
with ones based on<br>
security contexts.&nbsp; So config tools should be prompting for your
password instead of root password.&nbsp; <br>
<br>
One goal of userland changes is that the average user should not have
to know that he is running<br>
on a SELinux machine.&nbsp; A system administrator should be able to manage
the machine with limited knowlege of the way policy works.<br>
<blockquote type="cite"
 cite="mid2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz">
  <pre wrap="">I'm still working on getting my test system up to the new 2.4 and 2.6,
unfortunately I rendered it unbootable last night so it will take a little
longer than expected ( note to self : make sure kernel can build an initrd
before removing /boot/initrd* ).

Kerry


Stephen Smalley said:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Tue, 2003-10-14 at 08:15, Carlos An&Atilde;&shy;sio Monteiro wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Please, where I find the commands: avc_toggle and avc_enforcing. What
are it the packages where it are?
      </pre>
    </blockquote>
    <pre wrap="">They no longer exist as programs.  With the new SELinux API, you can
simply 'cat /selinux/enforce' to see the current enforcing value,
'echo 1 &gt; /selinux/enforce' to switch into enforcing mode, and
'echo  &gt; /selinux/enforce' to switch into permissive mode (if permitted
by the policy).

--
Stephen Smalley <a class="moz-txt-link-rfc2396E" href="mailto:sds@epoch.ncsc.mil">&lt;sds@epoch.ncsc.mil&gt;</a>
National Security Agency
    </pre>
  </blockquote>
  <pre wrap=""><!---->

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with
the words "unsubscribe selinux" without quotes as the message.
  </pre>
</blockquote>
</body>
</html>

--------------000105070903010202000504--


--------------090302060106020307020007--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
