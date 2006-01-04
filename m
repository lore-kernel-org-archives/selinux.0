Message-ID: <43BBF162.4010403@kaigai.gr.jp>
Date: Thu, 05 Jan 2006 01:01:38 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>,
   linux-security-module@wirex.com, selinux@tycho.nsa.gov
Subject: Re: SELinux metadata protection
References: <200601021906.k02J6HmB009362@luminouswebdesign.com> <1136303210.27632.65.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136303210.27632.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for your comments.

OK, I understood positioning of filename in SELinux.
I wanted to confirm whether it was metadata or not at first
because it seems to me a bit unclarity.

Drop previous two patches.

>>Casey takes a deep breath...
>>
>>The filename is not an attribute of the file.
>>The pathname components are data contained
>>in directory entries. The association of path name
>>to inode number is one way. There is no association
>>of path name from file. Really. This is the thing
>>that make audit hard.
>>
>>Yes, I know "It's obvious". It's just not true.
> 
> 
> The world is ending because I agree with Casey on this one...
> The filename is not an attribute of the file, and we do not want this
> type of filtering on directory reads.  Use the permissions on the
> directory itself to control who can see the names it contains.  It is
> the data container for the filenames.
> 
> Use polyinstantiation aka Multi-Level Directories aka moldy directories
> for shared directories like /tmp.

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
