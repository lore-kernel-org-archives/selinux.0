Subject: Re: [SEAndroid] checkpolicy missing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <CAGGozWRbYT9DFqjrpwxSjrZQiaePXAG5jx8ufJ2cVG7xWi+8Eg@mail.gmail.com>
References: 
	 <CAGGozWRbYT9DFqjrpwxSjrZQiaePXAG5jx8ufJ2cVG7xWi+8Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Mar 2012 08:47:07 -0500
Message-ID: <1331214427.13585.54.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-03-08 at 14:38 +0100, Bhargava Shastry wrote:
> Hi,
> 
> After a repo sync, make clean and make of SEAndroid sources, I see the
> following error:
> 
> make: *** No rule to make target `out/host/linux-x86/bin/checkpolicy',
> needed by
> `out/target/product/crespo/obj/ETC/sepolicy_intermediates/sepolicy.24'.  Stop.
> 
> Is the checkpolicy binary supposed to be part of the [SEAndroid]
> sources? Apologies if I missed a detail on the wiki.

Did you grab the latest local_manifest.xml file?  There have been
changes to it over time to add further projects (e.g. libsepol,
checkpolicy) and to address the partial merge by AOSP of some of our
projects and changes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
