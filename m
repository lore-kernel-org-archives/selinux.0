Subject: Re: [SEMANAGE] Const in APIs (part 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43BD77BA.7060303@cornell.edu>
References: <43BD77BA.7060303@cornell.edu>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 09:50:31 -0500
Message-Id: <1136559031.16811.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-05 at 14:47 -0500, Ivan Gyurdiev wrote:
> Marks lots of libsemanage things const.
> 
> Note that I haven't been including semanageswig_wrap.c changes into any 
> of my patches, since it makes them really huge. If you want
>  that file to be up to date, please rebuild it..

Yes, I rebuild it each time someone submits a patch for the interface
file.  Thanks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
