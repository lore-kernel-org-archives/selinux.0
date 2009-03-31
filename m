Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VLB9Ln020988
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 17:11:09 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VLB8Q0000864
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 21:11:08 GMT
Message-ID: <49D28656.1090504@rubix.com>
Date: Tue, 31 Mar 2009 23:08:38 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        cpebenito@tresys.com, selinux@tycho.nsa.gov, refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com> <49D1EAE7.8050100@rubix.com> <49D21FD5.7020600@kaigai.gr.jp> <49D23288.2030807@rubix.com> <49D27E6C.5000106@kaigai.gr.jp> <49D27F77.4040906@rubix.com> <49D2812B.50504@manicmethod.com>
In-Reply-To: <49D2812B.50504@manicmethod.com>
Content-Type: multipart/alternative;
 boundary="------------050407000803000508080902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050407000803000508080902
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



Joshua Brindle wrote:
> Andy Warner wrote:
>   
>> KaiGai Kohei wrote:
>>     
>>>> I am referring to things like:
>>>>
>>>> mlsconstrain { db_tuple } { use select }
>>>>     (( l1 dom l2 ) or
>>>>      (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
>>>>      ( t1 == mlsdbread ) or
>>>>      ( t2 == mlstrustedobject ));
>>>>     
>>>>         
>>> I noticed the db_xxx:{use} permission remained here. :-)
>>>   
>>>       
>> The example I used above is from an older version of the reference policy.
>>     
>>>   
>>>       
>>>> where t1 == mlsdbread seems to imply an object is trusted to read 
>>>> strictly dominating objects. Unless I am missing the meaning here, I 
>>>> would call this a MAC override. I realize there is no concept of a TE 
>>>> override, but MLS is part of MAC, no? And, this violates B&L rules. This 
>>>> is something we would control with a Security Administrator "role". Or, 
>>>> is this mlsdbread something that is impossible to give to a domain in a 
>>>> DBMS policy?
>>>>     
>>>>         
>>> It is different from my usage of terms.
>>> Some of domains are allowed to access the tuple, and others are
>>> disallowed as the result of access controls using the security
>>> policy.
>>>
>>> I understood the term of "MAC override" to express what actions
>>> are allowed without any checks based on security policy, as if
>>> root stuff can ignore DAC checks.
>>>   
>>>       
>> Ya, definitions, definitions :-) Coming from an MLS world, MAC override 
>> meant superseding the B&L policy. In a general sense we use special 
>> authorizations for that (our Security Admin role), while SELinux has a 
>> built in mechanism (mlsdbread)
>>     
>
> SELinux doesn't have a built in mechanism, 

By built in mechanism I meant exactly what you describe below. Maybe it
wasn't the best choice of words. The SELinux policy (the MLS policy)
provides a mechanism for the policy writer to assign the ability to
violate B&L information flow. Thus, it would be redundant for the
db_database object to have a permissions for something like "read-up",
etc. If I were to compare that with the Trusted Solaris type policy
mechanism, there was no such mechanism. Our DB would have to perform the
dominance check for an operation, then decide ourselves if the user had
sufficient authorizations to violate B&L. With the current SELinux MLS
policy, all of that is done with one access check. The mac override type
privilege you would see in TSol 8, etc would allow a process to perform
some operation while ignoring the mac policy. This does not help our DB
make a policy decision on a subject as they access a DBMS object.
> mlsdbread is an attribute that you
> give to domains that can violate this particular MLS constraint. Rather than
> having a generic MAC_OVERRIDE like other MLS implementations we went with finer
> grained overrides, you can see them all in kernel/mls.te.
>   
Yep, thats where i got the example above. Our past approach was to
disallow any mac override directly and let them change their session
level. We would then restrict them to read or read/write depending on
their authorizations. The selinux mechanism is better as, by its nature,
it may target specific objects, specific subjects, and specific overrides.
> there are also interfaces in mls.if to do the various overrides (rather than
> adding the attribute yourself), for example if you wanted foo_t to be able to
> read files of all levels you could call:
>
> mls_file_read_all_levels(foo_t)
>
> http://oss.tresys.com/docs/refpolicy/api/kernel_mls.html
>
>   

--------------050407000803000508080902
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-2022-JP"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Joshua Brindle wrote:
<blockquote cite="mid:49D2812B.50504@manicmethod.com" type="cite">
  <pre wrap="">Andy Warner wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">
KaiGai Kohei wrote:
    </pre>
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">I am referring to things like:

mlsconstrain { db_tuple } { use select }
    (( l1 dom l2 ) or
     (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
     ( t1 == mlsdbread ) or
     ( t2 == mlstrustedobject ));
    
        </pre>
      </blockquote>
      <pre wrap="">I noticed the db_xxx:{use} permission remained here. :-)
  
      </pre>
    </blockquote>
    <pre wrap="">The example I used above is from an older version of the reference policy.
    </pre>
    <blockquote type="cite">
      <pre wrap="">  
      </pre>
      <blockquote type="cite">
        <pre wrap="">where t1 == mlsdbread seems to imply an object is trusted to read 
strictly dominating objects. Unless I am missing the meaning here, I 
would call this a MAC override. I realize there is no concept of a TE 
override, but MLS is part of MAC, no? And, this violates B&amp;L rules. This 
is something we would control with a Security Administrator "role". Or, 
is this mlsdbread something that is impossible to give to a domain in a 
DBMS policy?
    
        </pre>
      </blockquote>
      <pre wrap="">It is different from my usage of terms.
Some of domains are allowed to access the tuple, and others are
disallowed as the result of access controls using the security
policy.

I understood the term of "MAC override" to express what actions
are allowed without any checks based on security policy, as if
root stuff can ignore DAC checks.
  
      </pre>
    </blockquote>
    <pre wrap="">Ya, definitions, definitions :-) Coming from an MLS world, MAC override 
meant superseding the B&amp;L policy. In a general sense we use special 
authorizations for that (our Security Admin role), while SELinux has a 
built in mechanism (mlsdbread)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
SELinux doesn't have a built in mechanism, </pre>
</blockquote>
<br>
By built in mechanism I meant exactly what you describe below. Maybe it
wasn't the best choice of words. The SELinux policy (the MLS policy)
provides a mechanism for the policy writer to assign the ability to
violate B&amp;L information flow. Thus, it would be redundant for the
db_database object to have&nbsp; a permissions for something like "read-up",
etc. If I were to compare that with the Trusted Solaris type policy
mechanism, there was no such mechanism. Our DB would have to perform
the dominance check for an operation, then decide ourselves if the user
had sufficient authorizations to violate B&amp;L. With the current
SELinux MLS policy, all of that is done with one access check. The mac
override type privilege you would see in TSol 8, etc would allow a
process to perform some operation while ignoring the mac policy. This
does not help our DB make a policy decision on a subject as they access
a DBMS&nbsp; object.<br>
<blockquote cite="mid:49D2812B.50504@manicmethod.com" type="cite">
  <pre wrap="">mlsdbread is an attribute that you
give to domains that can violate this particular MLS constraint. Rather than
having a generic MAC_OVERRIDE like other MLS implementations we went with finer
grained overrides, you can see them all in kernel/mls.te.
  </pre>
</blockquote>
Yep, thats where i got the example above. Our past approach was to
disallow any mac override directly and let them change their session
level. We would then restrict them to read or read/write depending on
their authorizations. The selinux mechanism is better as, by its
nature, it may target specific objects, specific subjects, and specific
overrides.<br>
<blockquote cite="mid:49D2812B.50504@manicmethod.com" type="cite">
  <pre wrap="">
there are also interfaces in mls.if to do the various overrides (rather than
adding the attribute yourself), for example if you wanted foo_t to be able to
read files of all levels you could call:

mls_file_read_all_levels(foo_t)

<a class="moz-txt-link-freetext" href="http://oss.tresys.com/docs/refpolicy/api/kernel_mls.html">http://oss.tresys.com/docs/refpolicy/api/kernel_mls.html</a>

  </pre>
</blockquote>
</body>
</html>

--------------050407000803000508080902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
