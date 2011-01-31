Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0VDAjjJ018510
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 08:10:45 -0500
Received: from house.lunarmania.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0VDAiu5011770
	for <selinux@tycho.nsa.gov>; Mon, 31 Jan 2011 13:10:44 GMT
Message-ID: <4D46B4CA.6010908@rubix.com>
Date: Mon, 31 Jan 2011 14:10:34 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
CC: "Ger Lawlor (gelawlor)" <gelawlor@cisco.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: Re: Tiny version of SE-PostgreSQL got merged
References: <4D466F3B.6090906@ak.jp.nec.com> <0B31D28E10F4FA489A0261135B94A14804A456B3@XMB-AMS-109.cisco.com> <4D469BA4.8@itechfrontiers.com> <4D46A10F.6060809@rubix.com> <0B31D28E10F4FA489A0261135B94A14804A45790@XMB-AMS-109.cisco.com> <4D46A8AB.1010904@itechfrontiers.com>
In-Reply-To: <4D46A8AB.1010904@itechfrontiers.com>
Content-Type: multipart/alternative;
 boundary="------------050204020809040401060608"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050204020809040401060608
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Trusted RUBIX was EAL-4 evaluated, according to the common criteria, for 
the MLS, DAC, policies and others. I lead that effort, so I am familiar 
with MLS evaluation requirements. But, it was a number of years ago. 
Also, Oracle OLS is eal-4 evaluated (as well as other security 
certifications).

Actually, just adding mls to a dbms does make it trusted from a security 
architecture perspective, but it may or may not be trusted (enough) by 
those who want to use it. That is, it is trusted to make MLS decisions. 
The required assurance, and the functionality that must be assured is, 
as you say, up to the requirements of organization that deploys the DBMS.

As for where to get information about Trusted DBMS's, you could start 
with the list of CC evaluated products. But, if you have a specific 
certification or evaluation requirement, I suggest you start with the 
websites for that particular certification. But, as I said before, as 
far as I know, SEPG, Trusted RUBIX, and Oracle OLS are the only active 
MLS DBMS products.

On 1/31/2011 1:18 PM, cto@itechfrontiers.com wrote:
> > Thanks. Where do I get info on DBMS’s that are trusted?
> Trusted DBMS depends on the practical use
>
> There was an Orange book that has been canceled since 2002
> http://www.dtic.mil/whs/directives/corres/pdf/850001p.pdf
>
>
> You can consult with The Common Criteria for Information technology 
> Security Evaluation
> http://www.commoncriteriaportal.org/
>
> also each department may have is own regulatory requirements:
>
> see section 2-5 on page 8 of this document:
> http://www.fas.org/irp/doddir/army/r380_19.pdf
>
>
> Just adding MLS does not make a DBMS, a trusted one.
>
> Best
>
> Patrick K.
>
>
>
> On 1/31/2011 6:49 AM, Ger Lawlor (gelawlor) wrote:
>> Thanks. Where do I get info on DBMS’s that are trusted? I have
>> considerations for Oracle Timesten, Informix IDS server and PostgresSQL.
>> Are there specific projects for these?
>>
>> *From:*Andy Warner [mailto:warner@rubix.com]
>> *Sent:* Monday, January 31, 2011 11:46 AM
>> *To:* cto@itechfrontiers.com
>> *Cc:* Ger Lawlor (gelawlor); KaiGai Kohei; selinux@tycho.nsa.gov
>> *Subject:* Re: Tiny version of SE-PostgreSQL got merged
>>
>> I would add that using a partitioned architecture (e.g., "it is possible
>> to achieve this by separation of databases and their storage location")
>> is not the same as having an integrated MLS database. There are certain
>> abilities that will not be nativly available, such as row based
>> polyinstantiation (I realize PG does not do this but others MLS DBMS's
>> do), true multi-level table views, and intra-table, inter-level key
>> uniqueness. There are other functionality that also would not be
>> possible with a partitioned approach. This is why, at least on some
>> level, Trusted DBMS's (MLS and other policies) continue to exist.
>>
>>
>> On 1/31/2011 12:23 PM, cto@itechfrontiers.com
>> <mailto:cto@itechfrontiers.com> wrote:
>>
>> Hello Ger.
>>
>> I actually asked this before from Mr. Kohei, and we had a hot debate
>> here I refer you to this archive:
>>
>> http://marc.info/?l=selinux&m=129178180819602&w=2
>> <http://marc.info/?l=selinux&m=129178180819602&w=2>
>>
>> Also this is original proposal of the project from Mr. KaiGai Kohei
>>
>> http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.pdf
>>
>> In brief:
>>
>> Since it is possible to use file labels and database locations and have
>> multiple instances of Postgresql as it is process based daemon, and just
>> separate classified and unclassified databases from each other
>>
>> BUT:
>>
>> the goal of Mr. KaiGai Kohei and se-postgresql project is to introduce
>> MLS (Multilevel Security) to the structure of the database and its ACL
>> model for each user of the database in example up to the rows and
>> columns, so in practice THEORETICALLY it would be possible to mix
>> classified or unclassified records within a single database and have
>> various levels of users with different levels of access
>> (however in practice it may not be recommended)
>>
>> Currently with PostgreSQL it is possible to achieve this by separation
>> of databases and their storage location; you have to completely separate
>> the datases, processes and daemons accessing such resources up to
>> different classifications you want to serve records on an MLS systems.
>>
>>
>>
>> Best,
>>
>> Patrick K.
>>
>>
>>
>>
>>
>> On 1/31/2011 5:09 AM, Ger Lawlor (gelawlor) wrote:
>>
>> I'm only new to SeLinux, but will have requirements around PostgreSQL.
>> Can you give me some background and info on why
>> This SE-PostgresQL exists? Is it specific to this database, or are there
>> similar projects for other database types?
>> Was it not possible to label files within a default installation? Was
>> this insufficient for Postgres security?
>>
>> Thanks,
>> Ger.
>>
>> -----Original Message-----
>> From: owner-selinux@tycho.nsa.gov <mailto:owner-selinux@tycho.nsa.gov>
>> [mailto:owner-selinux@tycho.nsa.gov]
>> On Behalf Of KaiGai Kohei
>> Sent: Monday, January 31, 2011 8:14 AM
>> To: selinux@tycho.nsa.gov <mailto:selinux@tycho.nsa.gov>
>> Subject: Tiny version of SE-PostgreSQL got merged
>>
>> A few days ago, a tiny initial version of SE-PostgreSQL got merged
>> in the v9.1 development cycle at this commit: http://bit.ly/gF2QPQ
>>
>> Although it omits various features which I planned at first, it
>> seems to me an ambitious first step.
>> PostgreSQL has shifted to provide a set of facilities to implement
>> label based mandatory access control, such as security label support
>> on database objects or security hooks being available for plug-in
>> modules.
>>
>> The current version of SE-PostgreSQL is implemented as a plugin
>> module that utilizes these hooks (but only a limited places are
>> covered), then it asks SELinux in kernel whether the required
>> access shall be allowed, or not.
>>
>> In the next development, I'd like to expand its access control coverage
>> using more fine grained security hooks. Right now, DDL permissions are
>> restrictions. Also, row-level security is in-progress feature.
>>
>> I have much things to do for the v9.2 or v9.3, however, I'd like to
>> appreciate people who have given me many feedbacks since 2006
>>
>> Thanks,
>>
>>
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> <mailto:majordomo@tycho.nsa.gov> with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--------------050204020809040401060608
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <font face="Arial">Trusted RUBIX was EAL-4 evaluated, according to
      the common criteria, for the MLS, DAC, policies and others.</font>
    I lead that effort, so I am familiar with MLS evaluation
    requirements. But, it was a number of years ago. Also, Oracle OLS is
    eal-4 evaluated (as well as other security certifications).<br>
    <br>
    Actually, just adding mls to a dbms does make it trusted from a
    security architecture perspective, but it may or may not be trusted
    (enough) by those who want to use it. That is, it is trusted to make
    MLS decisions. The required assurance, and the functionality that
    must be assured is, as you say, up to the requirements of
    organization that deploys the DBMS.<br>
    <br>
    As for where to get information about Trusted DBMS's, you could
    start with the list of CC evaluated products. But, if you have a
    specific certification or evaluation requirement, I suggest you
    start with the websites for that particular certification. But, as I
    said before, as far as I know, SEPG, Trusted RUBIX, and Oracle OLS
    are the only active MLS DBMS products.<br>
    <br>
    On 1/31/2011 1:18 PM, <a class="moz-txt-link-abbreviated" href="mailto:cto@itechfrontiers.com">cto@itechfrontiers.com</a> wrote:
    <blockquote cite="mid:4D46A8AB.1010904@itechfrontiers.com"
      type="cite">&gt; Thanks. Where do I get info on DBMS’s that are
      trusted?
      <br>
      Trusted DBMS depends on the practical use
      <br>
      <br>
      There was an Orange book that has been canceled since 2002
      <br>
      <a class="moz-txt-link-freetext" href="http://www.dtic.mil/whs/directives/corres/pdf/850001p.pdf">http://www.dtic.mil/whs/directives/corres/pdf/850001p.pdf</a>
      <br>
      <br>
      <br>
      You can consult with The Common Criteria for Information
      technology Security Evaluation
      <br>
      <a class="moz-txt-link-freetext" href="http://www.commoncriteriaportal.org/">http://www.commoncriteriaportal.org/</a>
      <br>
      <br>
      also each department may have is own regulatory requirements:
      <br>
      <br>
      see section 2-5 on page 8 of this document:
      <br>
      <a class="moz-txt-link-freetext" href="http://www.fas.org/irp/doddir/army/r380_19.pdf">http://www.fas.org/irp/doddir/army/r380_19.pdf</a>
      <br>
      <br>
      <br>
      Just adding MLS does not make a DBMS, a trusted one.
      <br>
      <br>
      Best
      <br>
      <br>
      Patrick K.
      <br>
      <br>
      <br>
      <br>
      On 1/31/2011 6:49 AM, Ger Lawlor (gelawlor) wrote:
      <br>
      <blockquote type="cite">Thanks. Where do I get info on DBMS’s that
        are trusted? I have
        <br>
        considerations for Oracle Timesten, Informix IDS server and
        PostgresSQL.
        <br>
        Are there specific projects for these?
        <br>
        <br>
        *From:*Andy Warner [<a class="moz-txt-link-freetext" href="mailto:warner@rubix.com">mailto:warner@rubix.com</a>]
        <br>
        *Sent:* Monday, January 31, 2011 11:46 AM
        <br>
        *To:* <a class="moz-txt-link-abbreviated" href="mailto:cto@itechfrontiers.com">cto@itechfrontiers.com</a>
        <br>
        *Cc:* Ger Lawlor (gelawlor); KaiGai Kohei; <a class="moz-txt-link-abbreviated" href="mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>
        <br>
        *Subject:* Re: Tiny version of SE-PostgreSQL got merged
        <br>
        <br>
        I would add that using a partitioned architecture (e.g., "it is
        possible
        <br>
        to achieve this by separation of databases and their storage
        location")
        <br>
        is not the same as having an integrated MLS database. There are
        certain
        <br>
        abilities that will not be nativly available, such as row based
        <br>
        polyinstantiation (I realize PG does not do this but others MLS
        DBMS's
        <br>
        do), true multi-level table views, and intra-table, inter-level
        key
        <br>
        uniqueness. There are other functionality that also would not be
        <br>
        possible with a partitioned approach. This is why, at least on
        some
        <br>
        level, Trusted DBMS's (MLS and other policies) continue to
        exist.
        <br>
        <br>
        <br>
        On 1/31/2011 12:23 PM, <a class="moz-txt-link-abbreviated" href="mailto:cto@itechfrontiers.com">cto@itechfrontiers.com</a>
        <br>
        <a class="moz-txt-link-rfc2396E" href="mailto:cto@itechfrontiers.com">&lt;mailto:cto@itechfrontiers.com&gt;</a> wrote:
        <br>
        <br>
        Hello Ger.
        <br>
        <br>
        I actually asked this before from Mr. Kohei, and we had a hot
        debate
        <br>
        here I refer you to this archive:
        <br>
        <br>
        <a class="moz-txt-link-freetext" href="http://marc.info/?l=selinux&amp;m=129178180819602&amp;w=2">http://marc.info/?l=selinux&amp;m=129178180819602&amp;w=2</a>
        <br>
<a class="moz-txt-link-rfc2396E" href="http://marc.info/?l=selinux&amp;m=129178180819602&amp;w=2">&lt;http://marc.info/?l=selinux&amp;m=129178180819602&amp;w=2&gt;</a>
        <br>
        <br>
        Also this is original proposal of the project from Mr. KaiGai
        Kohei
        <br>
        <br>
<a class="moz-txt-link-freetext" href="http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.pdf">http://sepgsql.googlecode.com/files/PGcon2010-KaiGai-LAPP_SELinux.pdf</a>
        <br>
        <br>
        In brief:
        <br>
        <br>
        Since it is possible to use file labels and database locations
        and have
        <br>
        multiple instances of Postgresql as it is process based daemon,
        and just
        <br>
        separate classified and unclassified databases from each other
        <br>
        <br>
        BUT:
        <br>
        <br>
        the goal of Mr. KaiGai Kohei and se-postgresql project is to
        introduce
        <br>
        MLS (Multilevel Security) to the structure of the database and
        its ACL
        <br>
        model for each user of the database in example up to the rows
        and
        <br>
        columns, so in practice THEORETICALLY it would be possible to
        mix
        <br>
        classified or unclassified records within a single database and
        have
        <br>
        various levels of users with different levels of access
        <br>
        (however in practice it may not be recommended)
        <br>
        <br>
        Currently with PostgreSQL it is possible to achieve this by
        separation
        <br>
        of databases and their storage location; you have to completely
        separate
        <br>
        the datases, processes and daemons accessing such resources up
        to
        <br>
        different classifications you want to serve records on an MLS
        systems.
        <br>
        <br>
        <br>
        <br>
        Best,
        <br>
        <br>
        Patrick K.
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        On 1/31/2011 5:09 AM, Ger Lawlor (gelawlor) wrote:
        <br>
        <br>
        I'm only new to SeLinux, but will have requirements around
        PostgreSQL.
        <br>
        Can you give me some background and info on why
        <br>
        This SE-PostgresQL exists? Is it specific to this database, or
        are there
        <br>
        similar projects for other database types?
        <br>
        Was it not possible to label files within a default
        installation? Was
        <br>
        this insufficient for Postgres security?
        <br>
        <br>
        Thanks,
        <br>
        Ger.
        <br>
        <br>
        -----Original Message-----
        <br>
        From: <a class="moz-txt-link-abbreviated" href="mailto:owner-selinux@tycho.nsa.gov">owner-selinux@tycho.nsa.gov</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:owner-selinux@tycho.nsa.gov">&lt;mailto:owner-selinux@tycho.nsa.gov&gt;</a>
        <br>
        [<a class="moz-txt-link-freetext" href="mailto:owner-selinux@tycho.nsa.gov">mailto:owner-selinux@tycho.nsa.gov</a>]
        <br>
        On Behalf Of KaiGai Kohei
        <br>
        Sent: Monday, January 31, 2011 8:14 AM
        <br>
        To: <a class="moz-txt-link-abbreviated" href="mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a> <a class="moz-txt-link-rfc2396E" href="mailto:selinux@tycho.nsa.gov">&lt;mailto:selinux@tycho.nsa.gov&gt;</a>
        <br>
        Subject: Tiny version of SE-PostgreSQL got merged
        <br>
        <br>
        A few days ago, a tiny initial version of SE-PostgreSQL got
        merged
        <br>
        in the v9.1 development cycle at this commit:
        <a class="moz-txt-link-freetext" href="http://bit.ly/gF2QPQ">http://bit.ly/gF2QPQ</a>
        <br>
        <br>
        Although it omits various features which I planned at first, it
        <br>
        seems to me an ambitious first step.
        <br>
        PostgreSQL has shifted to provide a set of facilities to
        implement
        <br>
        label based mandatory access control, such as security label
        support
        <br>
        on database objects or security hooks being available for
        plug-in
        <br>
        modules.
        <br>
        <br>
        The current version of SE-PostgreSQL is implemented as a plugin
        <br>
        module that utilizes these hooks (but only a limited places are
        <br>
        covered), then it asks SELinux in kernel whether the required
        <br>
        access shall be allowed, or not.
        <br>
        <br>
        In the next development, I'd like to expand its access control
        coverage
        <br>
        using more fine grained security hooks. Right now, DDL
        permissions are
        <br>
        restrictions. Also, row-level security is in-progress feature.
        <br>
        <br>
        I have much things to do for the v9.2 or v9.3, however, I'd like
        to
        <br>
        appreciate people who have given me many feedbacks since 2006
        <br>
        <br>
        Thanks,
        <br>
        <br>
        <br>
        <br>
        --
        <br>
        This message was distributed to subscribers of the selinux
        mailing list.
        <br>
        If you no longer wish to subscribe, send mail to
        <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a>
        <br>
        <a class="moz-txt-link-rfc2396E" href="mailto:majordomo@tycho.nsa.gov">&lt;mailto:majordomo@tycho.nsa.gov&gt;</a> with
        <br>
        the words "unsubscribe selinux" without quotes as the message.
        <br>
        <br>
      </blockquote>
      <br>
      <br>
      <br>
      --
      <br>
      This message was distributed to subscribers of the selinux mailing
      list.
      <br>
      If you no longer wish to subscribe, send mail to
      <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with
      <br>
      the words "unsubscribe selinux" without quotes as the message.
      <br>
    </blockquote>
  </body>
</html>

--------------050204020809040401060608--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
