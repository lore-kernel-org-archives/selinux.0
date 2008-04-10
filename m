Subject: Re: A Question about MLS in SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: zhao hui <zhaohui1976@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1a5e4bd80804091316m1b8cbb29i3f9ebb653b6f8bf9@mail.gmail.com>
References: <1a5e4bd80804091316m1b8cbb29i3f9ebb653b6f8bf9@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 07:38:58 -0400
Message-Id: <1207827538.21223.647.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-09 at 16:16 -0400, zhao hui wrote:
> In the book of <SELinux by Example>,in the chapter 8, there is a
> sentence says "
> 
> 
> 
> In recent enhancements to SELinux, the constraint feature has been
> extended to implement an optional multilevel security (MLS) policy.
> MLS is another form of mandatory access control, which is built upon
> type enforcement (TE). In this chapter, we explore the optional MLS
> policy features.
> 
> 
> 
> What does the "MLS is built upon type enforcement (TE)" means?

In SELinux, we use type enforcement to identify and protect the subjects
that are allowed to override MLS in particular ways.  This is done by
expressing exceptions within the MLS constraints based on type
attributes that are then associated with specific domains and types in
the TE policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
