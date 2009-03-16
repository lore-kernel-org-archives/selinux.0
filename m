Subject: Re: adding LANG and XMODIFIER to newrole minimal environment
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40903151003l367d0f73j8a45e3332fe44763@mail.gmail.com>
References: <cadfc0e40903140914n681c634fw5945242dab71f139@mail.gmail.com>
	 <cadfc0e40903151003l367d0f73j8a45e3332fe44763@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 16 Mar 2009 11:12:53 -0400
Message-Id: <1237216373.1035.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-03-15 at 17:03 +0000, Xavier Toth wrote:
> On Sat, Mar 14, 2009 at 4:14 PM, Xavier Toth <txtoth@gmail.com> wrote:
> > Stephan,
> > What would you think of adding LANG and XMODIFIER to newroles minimal
> > environment for internationalization support? Alternatively maybe
> > newrole could support an option which is a list of env variables to
> > maintain.
> >
> > Ted
> >
> 
> Possible patch:

Why not just use newrole -p in that case?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
