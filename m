Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBG0QGRq009344
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2010 19:26:17 -0500
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBG0QENL013186
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 00:26:15 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.193])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id oBG0QCTO006362
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 09:26:12 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id oBG0QCE23825 for selinux@tycho.nsa.gov; Thu, 16 Dec 2010 09:26:12 +0900 (JST)
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id oBG0QC4E008502
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2010 09:26:12 +0900 (JST)
Message-ID: <4D095C98.5050106@ak.jp.nec.com>
Date: Thu, 16 Dec 2010 09:26:00 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: type bounds for files?
References: <20101215203720.GH18729@myhost.felk.cvut.cz>
In-Reply-To: <20101215203720.GH18729@myhost.felk.cvut.cz>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/12/16 5:37), Michal Svoboda wrote:
> Hello,
> 
> let's say I have a www service that's run through apache/selinux+ with
> its own domain say foo_t. The domain has write access to some files with
> type foo_data_t (which is files_type) through an allow rule.
> 
> Now, due to the 'typebound httpd_t foo_t' rule used with apache domains,
> I would normally also have to 'allow httpd_t foo_data_t : file ...'.
> 
> But today I saw another solution at work, which used an oddball rule
> where the foo_data_t was type bounded by another files_type, something
> like 'typebound http_user_data_t foo_data_t' (don't remember the
> bounding type's name exactly). This would make the www service work the
> expected way without the need for 'allow httpd_t foo_data_t : file ...'.
> 
> Is this a known behavior? What is the sense in typebounding file types?
> 
Yes, it is known. We had a similar discussion before:
  http://marc.info/?l=selinux&m=126771862818496&w=2

The type-boundary feature is originated from type-hierarchy feature
which has been supported in checkpolicy for several years.

Joshua said:
| The original hierarchy specified that if httpd_t had e.g., write access
| to httpd_sys_content_t then webapp_t could be given write access to
| webapp_content_t without httpd_t having direct access to webapp_content_t.
|
| This was done so that, in policy access controls, parents could be
| decoupled from children while still allowing child subjects to access
| child objects. One application of this was to have parents that,
| themselves, did not have access to children objects (or were not active
| at all).

It seems to me your use cases are right.
Maybe, the term of 'boundary' might make us hard to imagine this type
of functionality.

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
