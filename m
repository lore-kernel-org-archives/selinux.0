Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Stephen Bennett <spb@gentoo.org>
Cc: ivg2@cornell.edu, SELinux@tycho.nsa.gov
In-Reply-To: <1105566046.3933.5.camel@localhost>
References: <1105390249.8093.21.camel@cobra.ivg2.net>
	 <1105474095.20566.131.camel@moss-spartans.epoch.ncsc.mil>
	 <1105560687.11135.26.camel@cobra.ivg2.net>
	 <1105566046.3933.5.camel@localhost>
Content-Type: text/plain
Message-Id: <1105566504.23136.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 16:48:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 16:40, Stephen Bennett wrote:
> With only one type per file, it's possible to look at the policy and be
> certain (for example) that domain1 can't affect domain2 in any way,
> because there are no interactions allowed between the two, and the file
> types they can access don't overlap. If you allow multiple contexts per
> file, that ability goes out of the window, and you have to look at which
> files have multiple contexts and what contexts they are before you can
> figure out where information can and can't flow.
> 
> Of course I may be off here, and I may have missed more subtleties, but
> that's the problem I can see with multiple types per file. Someone
> correct me if I'm wrong here. :)

Thanks, another voice of reason...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
