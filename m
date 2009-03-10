Subject: Re: [PATCH] libselinux: cache avc_compute_create results in the avc
From: Eric Paris <eparis@redhat.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ajax@redhat.com,
        method@manicmethod.com, joe@nall.com, txtoth@gmail.com
In-Reply-To: <49B5B922.30204@tycho.nsa.gov>
References: <1236029086.5466.36.camel@localhost.localdomain>
	 <49B5B922.30204@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 09 Mar 2009 22:00:20 -0400
Message-Id: <1236650420.3746.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-03-09 at 20:49 -0400, Eamon Walsh wrote:
> Eric Paris wrote:

I'll send a new one taking all of your comments into account tomorrow.
Thanks!

> >  	}
> > +	/* there is nothing in the avd for this tuple, so, lets get something */
> > +	avc_release_lock(avc_lock);
> > +	avc_has_perm_noaudit(ssid, tsid, tclass, 0, &aeref, NULL);
> >   
> 
> Nice hack.  I'm going to use this as ammunition next time the argument
> comes up about whether requests for zero permissions should succeed or fail.
> 
> This will set errno but it's not our fault if that affects something
> down the line.  I wonder if there might be other side effects though -
> in particular, is this going to pollute the kernel's AVC with entries
> for these ssid, tsid pairs?  Steve?

I could have just as easily made a request for an arbitrary permission.
All we want is some entry.  I did notice though when I wrote this that
the kernel has some BUG_ON with 0 perms and usespace didn't care.

The kernel doesn't call into its AVC when requests come
through /selinux/create.  It uses security_compute_av() directly, so in
kernel, we won't care at all.

> > @@ -1000,12 +1039,16 @@ static inline void avc_update_node(uint3
> >  	case AVC_CALLBACK_AUDITDENY_DISABLE:
> >  		node->ae.avd.auditdeny &= ~perms;
> >  		break;
> > +	case AVC_CALLBACK_ADD_CREATE:
> > +		node->ae.create_sid = create_sid;
> > +		node->ae.create_decided = 1;
> > +		break;
> >   
> 
> Thought this overwrite could be a refcount issue, but on closer look it
> doesn't seem like we hold refcounts for sids in the cache.  Just ignore
> this for now.

Yeah, looks like we only refcnt sids we pass out of the library.  These
would just get cleaned up when we remove the sid in the library.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
