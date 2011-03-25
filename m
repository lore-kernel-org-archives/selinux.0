Subject: Re: about ss
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yao <yffbrave@163.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1b9e718.65d4.12eeba32854.Coremail.yffbrave@163.com>
References: <1300886666.26747.15.camel@moss-pluto>
	 <1300710582.29422.12.camel@moss-pluto>
	 <1300456978.25429.29.camel@moss-pluto>
	 <3030f704.11efc.12ec66a93b9.Coremail.yffbrave@163.com>
	 <23980a51.520f.12ed66596db.Coremail.yffbrave@163.com>
	 <b41b75.151b.12ee0439347.Coremail.yffbrave@163.com>
	 <1b9e718.65d4.12eeba32854.Coremail.yffbrave@163.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 08:43:27 -0400
Message-ID: <1301057007.22099.11.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-03-25 at 14:11 +0800, Yao wrote:
> Well, my idea is based on a paper "Secure In-VM Monitoring Using
> Hardware Virtualization"(CCS'09). I will appreciate if you spend some
> time to look through the content & check if what I did is right.

If I understand correctly, that paper is about co-locating a monitoring
service in the same VM as the operating system being monitored.  But the
security server is not a monitoring service; it is a policy engine
invoked by the kernel.  So I don't think this applies.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
