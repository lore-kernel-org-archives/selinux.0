Subject: RE: I would like to propose that we add compression to
	handleallpolicy files on disk.
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514F33@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588514F33@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 14:11:12 -0500
Message-Id: <1163099472.32083.55.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-09 at 13:50 -0500, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > On Thu, 2006-11-09 at 12:00 -0500, Joshua Brindle wrote:
> > > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > > > 
> > > > On Thu, 2006-11-09 at 10:13 -0500, Stephen Smalley wrote:
> > > > > On Thu, 2006-11-09 at 09:34 -0500, Joshua Brindle wrote:
> > > 
> > > Karl suggested that we can compress the policy packages but not the 
> > > kernel policy. As long as this isn't a policy package format change 
> > > (eg., the policy packages in /usr/share/selinux are the 
> > same they've 
> > > always been) and it is only libsemanage manipulating the 
> > files in the 
> > > store I'm fine with that. The module store is a private resource of 
> > > libsemanage so nothing else should be affected in any way by this.
> > > 
> > 
> > Making semodule recognize bzipped files should be pretty 
> > simple as well
> > - why wouldn't we do that to save space in /usr/share/selinux?
> > 
> 
> What about everything else that will read modules (including setools in
> the future)?

It's a small amount of logic to detect.

>  They need to be stored in their native format and I don't
> think that libsepol should link against a compression library to make
> that happen.

What's wrong with letting libsepol dlopen libbz2.so?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
