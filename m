Subject: Re: libsemanage patch to handle installation problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1159542072.3592.12.camel@twoface.columbia.tresys.com>
References: <451BEFA4.60507@redhat.com>
	 <1159463932.11489.44.camel@moss-spartans.epoch.ncsc.mil>
	 <1159464256.11489.48.camel@moss-spartans.epoch.ncsc.mil>
	 <451C0C79.4000105@redhat.com>
	 <1159537518.29474.6.camel@twoface.columbia.tresys.com>
	 <1159538012.8496.35.camel@moss-spartans.epoch.ncsc.mil>
	 <451D3116.7030109@redhat.com>
	 <1159542072.3592.12.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 11:48:56 -0400
Message-Id: <1159544936.8496.84.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-29 at 11:01 -0400, Joshua Brindle wrote:
> On Fri, 2006-09-29 at 10:43 -0400, Daniel J Walsh wrote:
> > --- libsemanage-1.6.16/src/semanage_store.c~    2006-08-23
> > 13:57:48.000000000 -0400
> > +++ libsemanage-1.6.16/src/semanage_store.c     2006-09-29
> > 10:41:08.000000000 -0400
> > @@ -1106,6 +1106,10 @@
> >                         goto skip_reload;
> >                 }
> >         }
> > +       else 
> > +               if (errno == ENOENT && 
> > +                   strcmp(really_active_store, storepath) != 0)
> > +                       goto skip_reload;
> >  
> >         if (semanage_reload_policy(sh)) {
> >                 goto cleanup; 
> 
> Acked-By: Joshua Brindle <jbrindle@tresys.com>

Merged (with coding style cleanup) along with the other libsemanage
patches.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
