Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MBweO9024498
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 07:58:40 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MBwdfY011025
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 11:58:39 GMT
Message-ID: <4885CB56.9010700@rubix.com>
Date: Tue, 22 Jul 2008 13:58:14 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: questions about persistent storage of security contexts
References: <48851770.5020002@rubix.com>	 <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com> <1216692067.17786.21.camel@sulphur>
In-Reply-To: <1216692067.17786.21.camel@sulphur>
Content-Type: multipart/alternative;
 boundary="------------040701090806030204050500"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040701090806030204050500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Thanks for the info, all is now clear!

One more question (from an SELinux newbie!) that has been nagging away 
at me in regards to the MLS portion of the security context. In the MLS 
label we have the sensitivity (s0, s1, etc) and the category (c0, c2, 
etc). Now, as for the categories, its seems clear that in order for 
label1 to (potentially) dominate label2, then label1 must contain all 
the categories contained in label2 (i.e., *:c1,c3 can potentially 
dominate *:c3 where as *:c1 can never dominate *:c3). c0, c1, etc are 
just names of categories and the only relationship between them is 
equality or non-equality.

But with the sensitivity we have an ordering relationship, e.g., s3 is 
greater than (or higher, or strictly dominates) s1. The numbering 
applied to the sensitivity seems to imply (or define?) what that 
ordering is (s3 is greater than s1 because 3 is greater than 1). Is this 
numerical ordering a fixed part of the SELinux MLS policy or are the 
sensitivities simply "names" and how the policy is written defines the 
ordering. That is, is it possible for a configuration of SELinux MLS to 
have s0 strictly dominate s3?

My reason for asking is, if the "numerical ordering" of the 
sensitivities is always true then I can easily write my own functions to 
perform dominance checks of the MLS labels and those functions do not 
need to consult the SELinux API. If the sensitivities are just "names" 
and the policy instance can define any ordering relationship, then any 
functions written to perform dominance checks must call the SELinux API 
and seem non-trivial because no dominance check (only) API is provided 
and the TE behavior will somehow need to be "filtered" from the security 
check result.

Blessings,

Andy


Stephen Smalley wrote:
> On Mon, 2008-07-21 at 20:35 -0400, Eric Paris wrote:
>   
>> On Mon, Jul 21, 2008 at 7:10 PM, Andrew Warner <warner@rubix.com> wrote:
>>     
>>> Hello,
>>>
>>> I am currently developing an "SELinux aware" DBMS (primarily TE and MLS)
>>> that is characterized by:
>>>
>>> 1. The need to store a security context (in some recoverable form) in our
>>> persistent database (storage size of the context is an important factor)
>>> 2. The need to frequently perform a high number of security access checks in
>>> a performance sensitive way
>>>
>>> My question relates to the first characteristic from above. I am having
>>> trouble deciding on the best way to store the security context in the
>>> database. From my research I  see (I think!) three different representations
>>> for a security context: 1) string; 2) raw; 3) SID.
>>>
>>> The string representation, generally, seems clear as this is what is shown
>>> in all documentation as the context representation that exists in user
>>> space. My only question regarding the string representation is: is there is
>>> any hard limit to the length of the security context string? Do I need to
>>> allow for no theoretical size limit on a context string if I choose to store
>>> it?
>>>       
>> No hard limit that I can think of. There might be one somewhere but I
>> wouldn't count on it.
>>     
>
> Correct - the core logic imposes no fixed limits on the context strings,
> although the kernel interfaces do impose certain practical limits (e.g.
> page size).  The NFSv4 support will likewise impose certain limits in
> accordance with existing limits on the size of containing structures.
>
>   
>>> I am inferring the the raw representation exists from seeing *_raw functions
>>> (e.g., security_compute_create_raw) referenced in selinux header files.
>>> Other than seeing these functions declared I am having trouble finding out
>>> much about a raw representation. Is there any advantage to
>>> storing/manipulating a context in its raw representation? That is, are they
>>> more suited for a fast security access check, are they smaller in size, or
>>> do they have a fixed or maximum length?
>>>       
>> The _raw is actually what you want.  _raw basically just means strings
>> without any translations from things like mcstransd.  Given a context
>> like user_u:role_r:type_t the "raw" on an MLS system maybe
>> "user_u:object_r:type_t::s0."  Throwing a context with the MLS portion
>> attched at the !raw functions will work just fine.
>>
>>     
>>> The SID I have also seen mentioned in various documentations but can
>>> determine little about them. My guess is that they are an integer value that
>>> is used for fast internal access, particularly for the AVC. Are SIDs indeed
>>> integer values? Are they persistent or are they meaningful only for a
>>> particular OS session?
>>>       
>> That's exactly what they are.  They are kernel internal integer
>> representations that are (for the most part) only meaningful for that
>> session.  There are some 'initial sids' that are always the same, but
>> no userspace app should care about 'sids' in the general sense.
>>
>>     
>>> I have also considered maintaining my own internal, persistent mapping
>>> between string based contexts and an integer representation, the mapping
>>> being stored/indexed inside the DBMS. This gives me a small storage overhead
>>> with a fixed size.
>>>       
>> I don't have a problem with internal mapping like that.
>>     
>
> The original SELinux filesystem labeling implementation used something
> like that - they were called "persistent security identifiers" (PSIDs),
> and were maintained as private indices per-filesystem that mapped to
> security context strings.
>
>   
>> But, don't we already have sepostgresql?  Maybe you should be looking
>> to see if that fits your needs or you might get ideas from the work
>> that they performed?
>>     
>
> Yes, I'd recommend looking at SE-PostgreSQL as a worked example of
> applying the Flask architecture to a DBMS, including not only its
> approach to storing security contexts but also its approach to the
> userspace AVC.  You can find a link to that work from the Related Work
> page off of the SELinux web site.
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   

--------------040701090806030204050500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Thanks for the info, all is now clear!<br>
<br>
One more question (from an SELinux newbie!) that has been nagging away
at me in regards to the MLS portion of the security context. In the MLS
label we have the sensitivity (s0, s1, etc) and the category (c0, c2,
etc). Now, as for the categories, its seems clear that in order for
label1 to (potentially) dominate label2, then label1 must contain all
the categories contained in label2 (i.e., *:c1,c3 can potentially
dominate *:c3 where as *:c1 can never dominate *:c3). c0, c1, etc are
just names of categories and the only relationship between them is
equality or non-equality.<br>
<br>
But with the sensitivity we have an ordering relationship, e.g., s3 is
greater than (or higher, or strictly dominates) s1. The numbering
applied to the sensitivity seems to imply (or define?) what that
ordering is (s3 is greater than s1 because 3 is greater than 1). Is
this numerical ordering a fixed part of the SELinux MLS policy or are
the sensitivities simply "names" and how the policy is written defines
the ordering. That is, is it possible for a configuration of SELinux
MLS to have s0 strictly dominate s3?<br>
<br>
My reason for asking is, if the "numerical ordering" of the
sensitivities is always true then I can easily write my own functions
to perform dominance checks of the MLS labels and those functions do
not need to consult the SELinux API. If the sensitivities are just
"names" and the policy instance can define any ordering relationship,
then any functions written to perform dominance checks must call the
SELinux API and seem non-trivial because no dominance check (only) API
is provided and the TE behavior will somehow need to be "filtered" from
the security check result.<br>
<br>
Blessings,<br>
<br>
Andy<br>
<br>
<br>
Stephen Smalley wrote:
<blockquote cite="mid:1216692067.17786.21.camel@sulphur" type="cite">
  <pre wrap="">On Mon, 2008-07-21 at 20:35 -0400, Eric Paris wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Mon, Jul 21, 2008 at 7:10 PM, Andrew Warner <a class="moz-txt-link-rfc2396E" href="mailto:warner@rubix.com">&lt;warner@rubix.com&gt;</a> wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Hello,

I am currently developing an "SELinux aware" DBMS (primarily TE and MLS)
that is characterized by:

1. The need to store a security context (in some recoverable form) in our
persistent database (storage size of the context is an important factor)
2. The need to frequently perform a high number of security access checks in
a performance sensitive way

My question relates to the first characteristic from above. I am having
trouble deciding on the best way to store the security context in the
database. From my research I  see (I think!) three different representations
for a security context: 1) string; 2) raw; 3) SID.

The string representation, generally, seems clear as this is what is shown
in all documentation as the context representation that exists in user
space. My only question regarding the string representation is: is there is
any hard limit to the length of the security context string? Do I need to
allow for no theoretical size limit on a context string if I choose to store
it?
      </pre>
    </blockquote>
    <pre wrap="">No hard limit that I can think of. There might be one somewhere but I
wouldn't count on it.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Correct - the core logic imposes no fixed limits on the context strings,
although the kernel interfaces do impose certain practical limits (e.g.
page size).  The NFSv4 support will likewise impose certain limits in
accordance with existing limits on the size of containing structures.

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">I am inferring the the raw representation exists from seeing *_raw functions
(e.g., security_compute_create_raw) referenced in selinux header files.
Other than seeing these functions declared I am having trouble finding out
much about a raw representation. Is there any advantage to
storing/manipulating a context in its raw representation? That is, are they
more suited for a fast security access check, are they smaller in size, or
do they have a fixed or maximum length?
      </pre>
    </blockquote>
    <pre wrap="">The _raw is actually what you want.  _raw basically just means strings
without any translations from things like mcstransd.  Given a context
like user_u:role_r:type_t the "raw" on an MLS system maybe
"user_u:object_r:type_t::s0."  Throwing a context with the MLS portion
attched at the !raw functions will work just fine.

    </pre>
    <blockquote type="cite">
      <pre wrap="">The SID I have also seen mentioned in various documentations but can
determine little about them. My guess is that they are an integer value that
is used for fast internal access, particularly for the AVC. Are SIDs indeed
integer values? Are they persistent or are they meaningful only for a
particular OS session?
      </pre>
    </blockquote>
    <pre wrap="">That's exactly what they are.  They are kernel internal integer
representations that are (for the most part) only meaningful for that
session.  There are some 'initial sids' that are always the same, but
no userspace app should care about 'sids' in the general sense.

    </pre>
    <blockquote type="cite">
      <pre wrap="">I have also considered maintaining my own internal, persistent mapping
between string based contexts and an integer representation, the mapping
being stored/indexed inside the DBMS. This gives me a small storage overhead
with a fixed size.
      </pre>
    </blockquote>
    <pre wrap="">I don't have a problem with internal mapping like that.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The original SELinux filesystem labeling implementation used something
like that - they were called "persistent security identifiers" (PSIDs),
and were maintained as private indices per-filesystem that mapped to
security context strings.

  </pre>
  <blockquote type="cite">
    <pre wrap="">But, don't we already have sepostgresql?  Maybe you should be looking
to see if that fits your needs or you might get ideas from the work
that they performed?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes, I'd recommend looking at SE-PostgreSQL as a worked example of
applying the Flask architecture to a DBMS, including not only its
approach to storing security contexts but also its approach to the
userspace AVC.  You can find a link to that work from the Related Work
page off of the SELinux web site.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with
the words "unsubscribe selinux" without quotes as the message.

  </pre>
</blockquote>
</body>
</html>

--------------040701090806030204050500--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
