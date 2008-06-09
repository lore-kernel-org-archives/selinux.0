Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59GFQ2l005929
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 12:15:26 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m59GFOiw006958
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 16:15:24 GMT
Received: by wr-out-0506.google.com with SMTP id c30so1095116wra.21
        for <selinux@tycho.nsa.gov>; Mon, 09 Jun 2008 09:15:21 -0700 (PDT)
Message-ID: <dd18b0c30806090915q3092591bqb0f7000b93a0c06c@mail.gmail.com>
Date: Mon, 9 Jun 2008 16:15:21 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: No AVC messages found
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1213018137.9375.0.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30806080143t6d601bacta7b3652331a48dbf@mail.gmail.com>
	 <1213018137.9375.0.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 9, 2008 at 1:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Sun, 2008-06-08 at 08:43 +0000, Justin Mattock wrote:
>> Hello; why do I receive this: No AVC messages found when I audit2allow -d when
>> I have this under dmesg:
>> [ 8395.499759] type=1701 audit(1212909990.108:3): auid=4294967295
>> uid=1000 gid=1000 ses=4294967295 subj=a-12:sysadm_r:sysadm_t pid=3389
>> comm="aterm" sig=6
>>
>> the only action that I took was "uptime" in a terminal, could this be it?
>> should I have seen the definition uptime in the AVC? i.g. /usr/sbin or  /*/*
>> or is this something diff.
>> regards;
>
> Not all audit messages are AVC messages.
>
> --
> Stephen Smalley
> National Security Agency
>
>

Hello; What might have caused this message to be triggered.
just so I get a better idea.
regards;


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
