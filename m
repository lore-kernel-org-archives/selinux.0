Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ME2jdW022778
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 09:02:45 -0500 (EST)
Received: from mail-old.asahi-net.or.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1MDw5MK019971
	for <selinux@tycho.nsa.gov>; Tue, 22 Feb 2005 13:58:06 GMT
Message-ID: <421B3B0A.4000109@kaigai.gr.jp>
Date: Tue, 22 Feb 2005 23:00:42 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: What is typealias and typeattribute
References: <4219E45B.2020501@kaigai.gr.jp> <1109004990.3073.85.camel@selinux>
In-Reply-To: <1109004990.3073.85.camel@selinux>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, Thankd for your comments.

I understood your exposition.
Indeed, such a syntax may not have enough compatibility for some macros.

The triger of this thread was a simple curiosity about the knowledge of
the syntax for policy configuration, merely.
I don't say about the necessity of those sentence structure.
Sorry, if my expression make you misunderstanding.

Thanks.

Christopher J. PeBenito wrote:
> On Mon, 2005-02-21 at 22:38 +0900, KaiGai Kohei wrote:
> 
>>I noticed some sentence structures not to understand the meaning well,
>>when I read policy_parse.y in checkpolicy.tgz.
>>
>>I think we can replace 'typealias' and 'typeattribute' with
>>'type ...' sentence structure completely.
>>So, It's not writen in 'Configuring the SELinux Policy', orz.
>>
>>Is it historical syntax? or does it have another purpose?
>>Please tell me.
> 
> 
> Typealias and typeattribute are recent additions, added since that
> document was written.  The original syntax only allowed applying an
> alias or an attribute on the type statement, as described in that doc.
> For example:
> 
> type etc_dhcp_t alias { etc_dhcpc_t etc_dhcpd_t }, file_type, sysadmfile;
> 
> However this is problematic if this is type statement is inside a macro,
> since you might not want to add aliases and attributes in general, or
> there are many types declared in the macro.  So typealias and
> typeattribute were created so aliases and attributes could be added
> outside the type statement.  If we wanted to add an alias and an
> attribute to a type created by the tmpfs_domain macro, it would look
> like this:
> 
> tmpfs_domain(foo)
> typealias foo_tmpfs_t alias foo_shm_t;
> typeattribute foo_tmpfs_t myattribute;
> 
> We do want to keep both syntaxes, since both are used in the policy.

--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
