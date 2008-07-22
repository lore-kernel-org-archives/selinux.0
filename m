Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MEV72S018272
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 10:31:08 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MEV6Hb026818
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 14:31:07 GMT
Message-ID: <4885EF10.2010506@rubix.com>
Date: Tue, 22 Jul 2008 16:30:40 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: questions about persistent storage of security contexts
References: <48851770.5020002@rubix.com>	 <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com>	 <1216692067.17786.21.camel@sulphur>  <4885CB56.9010700@rubix.com> <1216729949.3500.5.camel@sulphur>
In-Reply-To: <1216729949.3500.5.camel@sulphur>
Content-Type: multipart/alternative;
 boundary="------------010807000203070200010200"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010807000203070200010200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Stephen Smalley wrote:
> On Tue, 2008-07-22 at 13:58 +0200, Andy Warner wrote:
>   
>> Thanks for the info, all is now clear!
>>
>> One more question (from an SELinux newbie!) that has been nagging away
>> at me in regards to the MLS portion of the security context. In the
>> MLS label we have the sensitivity (s0, s1, etc) and the category (c0,
>> c2, etc). Now, as for the categories, its seems clear that in order
>> for label1 to (potentially) dominate label2, then label1 must contain
>> all the categories contained in label2 (i.e., *:c1,c3 can potentially
>> dominate *:c3 where as *:c1 can never dominate *:c3). c0, c1, etc are
>> just names of categories and the only relationship between them is
>> equality or non-equality.
>>
>> But with the sensitivity we have an ordering relationship, e.g., s3 is
>> greater than (or higher, or strictly dominates) s1. The numbering
>> applied to the sensitivity seems to imply (or define?) what that
>> ordering is (s3 is greater than s1 because 3 is greater than 1). Is
>> this numerical ordering a fixed part of the SELinux MLS policy or are
>> the sensitivities simply "names" and how the policy is written defines
>> the ordering. That is, is it possible for a configuration of SELinux
>> MLS to have s0 strictly dominate s3?
>>     
>
> Yes - they are just names and the dominance relationship is defined by
> the policy configuration.
>
> Computing dominance has been handled in a couple of different ways in
> the past:
> 1) Model it as a permission check, with a MLS constraint defined on the
> permission and allowing the type relationship.
> 2) Introduce an interface to the kernel security server to provide
> dominance computations.
>
> See the mailing list archives for more discussion.
>
>   
Is there any requirement that the MLS policy be Bell-LaPadula ? Or can 
it contain arbitrary information flows? (I am guessing the latter). If 
not BL, then does that make dominance relationships only something that 
can be determined for a subset of policy instances? I am assuming the 
LSPP evaluation uses a BL policy instance (?).

Thanks again for the info!

>> My reason for asking is, if the "numerical ordering" of the
>> sensitivities is always true then I can easily write my own functions
>> to perform dominance checks of the MLS labels and those functions do
>> not need to consult the SELinux API. If the sensitivities are just
>> "names" and the policy instance can define any ordering relationship,
>> then any functions written to perform dominance checks must call the
>> SELinux API and seem non-trivial because no dominance check (only) API
>> is provided and the TE behavior will somehow need to be "filtered"
>> from the security check result.
>>     
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   

--------------010807000203070200010200
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
<blockquote cite="mid:1216729949.3500.5.camel@sulphur" type="cite">
  <pre wrap="">On Tue, 2008-07-22 at 13:58 +0200, Andy Warner wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks for the info, all is now clear!

One more question (from an SELinux newbie!) that has been nagging away
at me in regards to the MLS portion of the security context. In the
MLS label we have the sensitivity (s0, s1, etc) and the category (c0,
c2, etc). Now, as for the categories, its seems clear that in order
for label1 to (potentially) dominate label2, then label1 must contain
all the categories contained in label2 (i.e., *:c1,c3 can potentially
dominate *:c3 where as *:c1 can never dominate *:c3). c0, c1, etc are
just names of categories and the only relationship between them is
equality or non-equality.

But with the sensitivity we have an ordering relationship, e.g., s3 is
greater than (or higher, or strictly dominates) s1. The numbering
applied to the sensitivity seems to imply (or define?) what that
ordering is (s3 is greater than s1 because 3 is greater than 1). Is
this numerical ordering a fixed part of the SELinux MLS policy or are
the sensitivities simply "names" and how the policy is written defines
the ordering. That is, is it possible for a configuration of SELinux
MLS to have s0 strictly dominate s3?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes - they are just names and the dominance relationship is defined by
the policy configuration.

Computing dominance has been handled in a couple of different ways in
the past:
1) Model it as a permission check, with a MLS constraint defined on the
permission and allowing the type relationship.
2) Introduce an interface to the kernel security server to provide
dominance computations.

See the mailing list archives for more discussion.

  </pre>
</blockquote>
Is there any requirement that the MLS policy be Bell-LaPadula ? Or can
it contain arbitrary information flows? (I am guessing the latter). If
not BL, then does that make dominance relationships only something that
can be determined for a subset of policy instances? I am assuming the
LSPP evaluation uses a BL policy instance (?). <br>
<br>
Thanks again for the info!<br>
<br>
<blockquote cite="mid:1216729949.3500.5.camel@sulphur" type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">My reason for asking is, if the "numerical ordering" of the
sensitivities is always true then I can easily write my own functions
to perform dominance checks of the MLS labels and those functions do
not need to consult the SELinux API. If the sensitivities are just
"names" and the policy instance can define any ordering relationship,
then any functions written to perform dominance checks must call the
SELinux API and seem non-trivial because no dominance check (only) API
is provided and the TE behavior will somehow need to be "filtered"
from the security check result.
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

--------------010807000203070200010200--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
