Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MAe6bh010102
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 06:40:06 -0400
Received: from house.lunarmania.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MAe5fY018968
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 10:40:05 GMT
Message-ID: <4885B8EB.9040809@rubix.com>
Date: Tue, 22 Jul 2008 12:39:39 +0200
From: Andrew Warner <warner@rubix.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: questions about persistent storage of security contexts
References: <48851770.5020002@rubix.com> <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com> <48853AA5.3040607@ak.jp.nec.com>
In-Reply-To: <48853AA5.3040607@ak.jp.nec.com>
Content-Type: multipart/alternative;
 boundary="------------060002060100020809070400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060002060100020809070400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the information. I have previously looked at the 
SE-PostgreSQL code/documentation. It was helpful and most interesting. 
The base DBMS I am using is called Trusted RUBIX, which is an CC EAL-4 
(Trusted Solaris) evaluated MLS DBMS. We have been contracted to 
integrate SELinux TE and MLS (Red Hat flavor) into our DBMS. So, 
obviously using SE-PostgreSQL is not an option :-) In the bigger 
picture, this current work is a small (and rather detached) step towards 
a high robustness (EAL-6+) DBMS solution.

Historically, our company (and myself personally) have been involved in 
high(er) assurance MLS DBMS products/research for a number of years. As 
such, we tend to use a more "traditional" minimized trust, reference 
monitor architecture as opposed to inserting hooks and using query 
modification for our security enforcement. This means, for instance, 
that a label object permeates much of our kernel code at a fairly low 
level as well as storage objects. Thus, the runtime and storage 
representation must be chosen carefully as it will touch much of our 
kernel code. We also support full polyinstantiation of named objects, 
which dictates an efficient label mechanism. (Integration of TE + MLS 
into traditional MLS polyinstantiation behavior is an interesting topic!)

Out of curiosity, KaiGai, a question about how SE-PostgreSQL presents 
the security context to a user. From your security guide I see that the 
context is a selectable column. But, what SQL type is the column? For 
instance, do you define your own SQL type, such as "Security Context" or 
is it a VARCHAR that has special constraints placed upon it to force it 
to conform to the structure of a security context?

Blessings,

Andy

KaiGai Kohei wrote:
>>> I have also considered maintaining my own internal, persistent mapping
>>> between string based contexts and an integer representation, the 
>>> mapping
>>> being stored/indexed inside the DBMS. This gives me a small storage 
>>> overhead
>>> with a fixed size.
>>
>> I don't have a problem with internal mapping like that.
>
> In SE-PostgreSQL, it maintains own internal mapping between text 
> represented
> security context and its integer identifier. The 'pg_security' system 
> catalog
> stores the pair of them.
>
> Any tuple (including system catalog) has its security context. It is 
> stored
> within padding area of HeapTupleHeader as an integer value, and it 
> means the
> primary key of 'pg_security' system catalog.
>
> It also enables to boost userspace AVC, because this idea makes 
> possible to
> implement it using a relationship between identifiers (not a text 
> representation).
>
>
> When the security policy is reloaded and it makes invalidate the 
> stored context,
> the stored one is dealt as 'unlabeled_t'.
>
>> But, don't we already have sepostgresql?  Maybe you should be looking
>> to see if that fits your needs or you might get ideas from the work
>> that they performed?
>
> FYI:
>   http://code.google.com/p/sepgsql/
>
> Andrew, what is your intended base RDBMS?
>
> Currently, SE-PostgreSQL is the only SELinux awared RDBMS.
> It is now under reviewing for the next release (v8.4) cycle.
>   http://wiki.postgresql.org/wiki/CommitFest:2008-07
>
> However, I think we can apply SELinux for any other relational model 
> implementation.
>
> Thanks,

--------------060002060100020809070400
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Arial">Thanks for the information. I have previously looked
at the SE-PostgreSQL code/documentation. It was helpful and most
interesting. The base DBMS I am using is called Trusted RUBIX, which is
an CC EAL-4 (Trusted Solaris) evaluated MLS DBMS. We have been
contracted to integrate SELinux TE and MLS (Red Hat flavor) into our
DBMS. So, obviously using SE-PostgreSQL is not an option :-) In the
bigger picture, this current work is a small (and rather detached) step
towards a high robustness (EAL-6+) DBMS solution. <br>
<br>
Historically, our company (and myself personally) have been involved in
high(er) assurance MLS DBMS products/research for a number of years. As
such, we tend to use a more "traditional" minimized trust, reference
monitor architecture as opposed to inserting hooks and using query
modification for our security enforcement. This means, for instance,
that a label object permeates much of our kernel code at a fairly low
level as well as storage objects. Thus, the runtime and storage
representation must be chosen carefully as it will touch much of our
kernel code. We also support full polyinstantiation of named objects,
which dictates an efficient label mechanism. (Integration of TE + MLS
into traditional MLS polyinstantiation behavior is an interesting
topic!) <br>
<br>
Out of curiosity, KaiGai, a question about how SE-PostgreSQL presents
the security context to a user. From your security guide I see that the
context is a selectable column. But, what SQL type is the column? For
instance, do you define your own SQL type, such as "Security Context"
or is it a VARCHAR that has special constraints placed upon it to force
it to conform to the structure of a security context? <br>
<br>
Blessings,<br>
<br>
Andy <br>
</font><br>
KaiGai Kohei wrote:
<blockquote cite="mid:48853AA5.3040607@ak.jp.nec.com" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">I have also considered maintaining my own
internal, persistent mapping
      <br>
between string based contexts and an integer representation, the
mapping
      <br>
being stored/indexed inside the DBMS. This gives me a small storage
overhead
      <br>
with a fixed size.
      <br>
    </blockquote>
    <br>
I don't have a problem with internal mapping like that.
    <br>
  </blockquote>
  <br>
In SE-PostgreSQL, it maintains own internal mapping between text
represented
  <br>
security context and its integer identifier. The 'pg_security' system
catalog
  <br>
stores the pair of them.
  <br>
  <br>
Any tuple (including system catalog) has its security context. It is
stored
  <br>
within padding area of HeapTupleHeader as an integer value, and it
means the
  <br>
primary key of 'pg_security' system catalog.
  <br>
  <br>
It also enables to boost userspace AVC, because this idea makes
possible to
  <br>
implement it using a relationship between identifiers (not a text
representation).
  <br>
  <br>
  <br>
When the security policy is reloaded and it makes invalidate the stored
context,
  <br>
the stored one is dealt as 'unlabeled_t'.
  <br>
  <br>
  <blockquote type="cite">But, don't we already have sepostgresql?&nbsp;
Maybe you should be looking
    <br>
to see if that fits your needs or you might get ideas from the work
    <br>
that they performed?
    <br>
  </blockquote>
  <br>
FYI:
  <br>
&nbsp; <a class="moz-txt-link-freetext" href="http://code.google.com/p/sepgsql/">http://code.google.com/p/sepgsql/</a>
  <br>
  <br>
Andrew, what is your intended base RDBMS?
  <br>
  <br>
Currently, SE-PostgreSQL is the only SELinux awared RDBMS.
  <br>
It is now under reviewing for the next release (v8.4) cycle.
  <br>
&nbsp; <a class="moz-txt-link-freetext" href="http://wiki.postgresql.org/wiki/CommitFest:2008-07">http://wiki.postgresql.org/wiki/CommitFest:2008-07</a>
  <br>
  <br>
However, I think we can apply SELinux for any other relational model
implementation.
  <br>
  <br>
Thanks,
  <br>
</blockquote>
</body>
</html>

--------------060002060100020809070400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
