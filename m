Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l83FBHAe023896
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 11:11:17 -0400
Received: from mail.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l83FBEjW010319
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2007 15:11:16 GMT
Received: from [127.0.0.1] (j069218.ppp.asahi-net.or.jp [61.213.69.218])
	by mail.asahi-net.or.jp (Postfix) with ESMTP id EB76E6448
	for <selinux@tycho.nsa.gov>; Tue,  4 Sep 2007 00:11:08 +0900 (JST)
Message-ID: <46DC2457.4010408@kaigai.gr.jp>
Date: Tue, 04 Sep 2007 00:12:23 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [ANN] SE-PostgreSQL 8.2.4-1.0 Released
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is announcement of the first official version of SE-PostgreSQL.

====================================================================
  SE-PostgreSQL 8.2.4-1.0 Released
====================================================================
SE-PostgreSQL development team released "SE-PostgreSQL 8.2.4-1.0" and
"The SE-PostgreSQL Security Guide (Japanese/English)".

You can get these packages from the following URL:
  http://code.google.com/p/sepgsql/downloads/list

NOTE: Any packages built for Fedora development edition (rawhide) will
      be distributed via Fedora mirrors soon.

* SE-PostgreSQL 8.2.4-1.0
  sepostgresql-8.2.4-1.0.fc7.i386.rpm
  sepostgresql-8.2.4-1.0.fc7.src.rpm
* The base security policy for Fedora 7
  selinux-policy-devel-2.6.4-38.sepgsql.fc7.noarch.rpm
  selinux-policy-targeted-2.6.4-38.sepgsql.fc7.noarch.rpm
  selinux-policy-2.6.4-38.sepgsql.fc7.noarch.rpm
  selinux-policy-2.6.4-38.sepgsql.fc7.src.rpm
* The official documentation
  sepgsql_security_guide.20070903.jp.pdf
  sepgsql_security_guide.20070903.en.pdf

See the following URL, for installation details.
* SE-PostgreSQL Installation Memo (Fedora 7)
  http://code.google.com/p/sepgsql/wiki/install_memo_Fedora7

The features of SE-PostgreSQL
-----------------------------
Security-Enhanced PostgreSQL (SE-PostgreSQL) is a security extension built
in PostgreSQL. It enables to apply a unified security policy of SELinux to
both operating system and database management system.
In addition, it also provides fine-grained access control including column
and row level, and mandatory access control being non-bypassable, even if
privileged database users.
These features enables to build a database management system into information
flow control scheme integrated with operating system, and to protect our
information asset from threats like manipulation or leaking.

The position of this version
----------------------------
This is the first official version of SE-PostgreSQL based on PostgreSQL 8.2.4.
However, it does not have enough achievement of works compared to the original
PostgreSQL. Therefore, we recommend you to have enough evaluation and
verification on its introduction.
The series of SE-PostgreSQL 8.2.4-1.x got into maintenance phase after the
release of this version, and we don't have any plan to release new version
in this series, except for bug fixes.
The SE-PostgreSQL development team has a plan to develop next major version
of SE-PostgreSQL based on PostgreSQL 8.3, with several new features.

Acknowledgment
--------------
The development of SE-PostgreSQL is supported by Exploratory Software Project,
IPA(Information-technology Promotion Agency, Japan).

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
