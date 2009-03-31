Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2VKfum7016850
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 16:41:56 -0400
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2VKftQ0026815
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 20:41:55 GMT
Message-ID: <49D27F77.4040906@rubix.com>
Date: Tue, 31 Mar 2009 22:39:19 +0200
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, cpebenito@tresys.com,
        method@manicmethod.com, selinux@tycho.nsa.gov,
        refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com> <49D1EAE7.8050100@rubix.com> <49D21FD5.7020600@kaigai.gr.jp> <49D23288.2030807@rubix.com> <49D27E6C.5000106@kaigai.gr.jp>
In-Reply-To: <49D27E6C.5000106@kaigai.gr.jp>
Content-Type: multipart/alternative;
 boundary="------------080602060205000906010606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080602060205000906010606
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit



KaiGai Kohei wrote:
>> I am referring to things like:
>>
>> mlsconstrain { db_tuple } { use select }
>>     (( l1 dom l2 ) or
>>      (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
>>      ( t1 == mlsdbread ) or
>>      ( t2 == mlstrustedobject ));
>>     
>
> I noticed the db_xxx:{use} permission remained here. :-)
>   
The example I used above is from an older version of the reference policy.
>   
>> where t1 == mlsdbread seems to imply an object is trusted to read 
>> strictly dominating objects. Unless I am missing the meaning here, I 
>> would call this a MAC override. I realize there is no concept of a TE 
>> override, but MLS is part of MAC, no? And, this violates B&L rules. This 
>> is something we would control with a Security Administrator "role". Or, 
>> is this mlsdbread something that is impossible to give to a domain in a 
>> DBMS policy?
>>     
>
> It is different from my usage of terms.
> Some of domains are allowed to access the tuple, and others are
> disallowed as the result of access controls using the security
> policy.
>
> I understood the term of "MAC override" to express what actions
> are allowed without any checks based on security policy, as if
> root stuff can ignore DAC checks.
>   
Ya, definitions, definitions :-) Coming from an MLS world, MAC override
meant superseding the B&L policy. In a general sense we use special
authorizations for that (our Security Admin role), while SELinux has a
built in mechanism (mlsdbread)
> Thanks,
>   

--------------080602060205000906010606
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
KaiGai Kohei wrote:
<blockquote cite="mid:49D27E6C.5000106@kaigai.gr.jp" type="cite">
  <blockquote type="cite">
    <pre wrap="">I am referring to things like:

mlsconstrain { db_tuple } { use select }
    (( l1 dom l2 ) or
     (( t1 == mlsdbreadtoclr ) and ( h1 dom l2 )) or
     ( t1 == mlsdbread ) or
     ( t2 == mlstrustedobject ));
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I noticed the db_xxx:{use} permission remained here. :-)
  </pre>
</blockquote>
The example I used above is from an older version of the reference
policy.<br>
<blockquote cite="mid:49D27E6C.5000106@kaigai.gr.jp" type="cite">
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
  <pre wrap=""><!---->
It is different from my usage of terms.
Some of domains are allowed to access the tuple, and others are
disallowed as the result of access controls using the security
policy.

I understood the term of "MAC override" to express what actions
are allowed without any checks based on security policy, as if
root stuff can ignore DAC checks.
  </pre>
</blockquote>
Ya, definitions, definitions :-) Coming from an MLS world, MAC override
meant superseding the B&amp;L policy. In a general sense we use special
authorizations for that (our Security Admin role), while SELinux has a
built in mechanism (mlsdbread)
<blockquote cite="mid:49D27E6C.5000106@kaigai.gr.jp" type="cite">
  <pre wrap="">
Thanks,
  </pre>
</blockquote>
</body>
</html>

--------------080602060205000906010606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
