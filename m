MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: I would like to propose that we add compression to handleallpolicy files on disk.
Date: Thu, 9 Nov 2006 13:50:18 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588514F33@exchange.columbia.tresys.com>
In-Reply-To: <1163097830.32083.52.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Thu, 2006-11-09 at 12:00 -0500, Joshua Brindle wrote:
> > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > > 
> > > On Thu, 2006-11-09 at 10:13 -0500, Stephen Smalley wrote:
> > > > On Thu, 2006-11-09 at 09:34 -0500, Joshua Brindle wrote:
> > 
> > Karl suggested that we can compress the policy packages but not the 
> > kernel policy. As long as this isn't a policy package format change 
> > (eg., the policy packages in /usr/share/selinux are the 
> same they've 
> > always been) and it is only libsemanage manipulating the 
> files in the 
> > store I'm fine with that. The module store is a private resource of 
> > libsemanage so nothing else should be affected in any way by this.
> > 
> 
> Making semodule recognize bzipped files should be pretty 
> simple as well
> - why wouldn't we do that to save space in /usr/share/selinux?
> 

What about everything else that will read modules (including setools in
the future)? They need to be stored in their native format and I don't
think that libsepol should link against a compression library to make
that happen.

> > This will slow down some otherwise cheap operations such as 
> semodule 
> > -l, rather than just opening the files and reading the policy name 
> > it'll have to decompress them first, I'm not sure what the 
> performance 
> > cost will be.. Perhaps this should be configurable as well.
> > 
> 
> If we make printing the version optional we should be able to 
> do this with only name mangling on the file names in the 
> module directory. We should probably make it possible just to 
> get a list of module names anyway to facilitate scripting.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
