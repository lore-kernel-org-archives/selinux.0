Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59IKgjw001412
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 14:20:42 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m59IKeiw016454
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 18:20:40 GMT
Received: by an-out-0708.google.com with SMTP id d30so531925and.75
        for <selinux@tycho.nsa.gov>; Mon, 09 Jun 2008 11:20:40 -0700 (PDT)
Message-ID: <dd18b0c30806091120l20128195o633acbd60972f4c9@mail.gmail.com>
Date: Mon, 9 Jun 2008 18:20:39 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: No AVC messages found
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1213029163.9375.81.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30806080143t6d601bacta7b3652331a48dbf@mail.gmail.com>
	 <1213018137.9375.0.camel@moss-spartans.epoch.ncsc.mil>
	 <dd18b0c30806090915q3092591bqb0f7000b93a0c06c@mail.gmail.com>
	 <1213029163.9375.81.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 9, 2008 at 4:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Mon, 2008-06-09 at 16:15 +0000, Justin Mattock wrote:
>> On Mon, Jun 9, 2008 at 1:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> >
>> > On Sun, 2008-06-08 at 08:43 +0000, Justin Mattock wrote:
>> >> Hello; why do I receive this: No AVC messages found when I audit2allow -d when
>> >> I have this under dmesg:
>> >> [ 8395.499759] type=1701 audit(1212909990.108:3): auid=4294967295
>> >> uid=1000 gid=1000 ses=4294967295 subj=a-12:sysadm_r:sysadm_t pid=3389
>> >> comm="aterm" sig=6
>> >>
>> >> the only action that I took was "uptime" in a terminal, could this be it?
>> >> should I have seen the definition uptime in the AVC? i.g. /usr/sbin or  /*/*
>> >> or is this something diff.
>> >> regards;
>> >
>> > Not all audit messages are AVC messages.
>> >
>> > --
>> > Stephen Smalley
>> > National Security Agency
>> >
>> >
>>
>> Hello; What might have caused this message to be triggered.
>> just so I get a better idea.
>> regards;
>
> Use /sbin/ausearch -i to interpret the audit messages in a more readable
> form.  And ask questions about audit not related to selinux on
> linux-audit@redhat.com list after subscribing there.
>
> In this case, type=1701 corresponds to AUDIT_ANON_ABEND in
> include/linux/audit.h, which means a process died abnormally.
>
> --
> Stephen Smalley
> National Security Agency
>
>

Alright; thanks for the info, If I see anything interesting with
SELinux I'll let you guy's know, and then
with any audit related stuff I'll inform linux-audit.
regards;


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
