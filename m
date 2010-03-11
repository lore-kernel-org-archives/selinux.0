Subject: Re: how to cope with file renames?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20100311170014.GE24034@myhost.felk.cvut.cz>
References: <20100311081913.GC24034@myhost.felk.cvut.cz>
	 <1268315218.16780.10.camel@moss-pluto.epoch.ncsc.mil>
	 <20100311170014.GE24034@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Thu, 11 Mar 2010 12:27:02 -0500
Message-Id: <1268328422.16780.28.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-11 at 18:00 +0100, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > http://pecl.php.net/package/selinux
> 
> Thanks!
> 
> > > In short, I was wondering if there was a way for a rename()d file to be
> > > subjected to a type transition as if a new file was created? (I tried a
> > > type_trans rule but to no avail.) Or any other way to deal with renaming
> > > files between variously contexted dirs?
> > 
> > No.  The best way of course is to create the file with the right
> > security context in the first place, whether explicitly or by uploading
> > it to the same parent directory as the final destination.
> 
> That's what I do right now. I can do that because there's only one
> context. But in a web service your script isn't invoked until the file
> is already uploaded. So you can't pre-set the correct context and/or
> destination if you have two or more possibilities.
> 
> > Alternatively the php scriptlet can use the selinux bindings to
> > manipulate the context, or you can configure restorecond(8) to watch
> > for the destination file and reset its security context as needed.
> 
> Does restorecond handle recursive directory restoring yet? (Last time I
> tried it worked only on single files.)
> 
> But yes, in principle a cron job with 'restorecon -R' is a way too. But
> all those solutions are 'dirty', because they need you to make an extra
> effort. There's already a huge infrastructure with type inheritance and
> transitions, as to make the labeling independent of the application; but
> the rename operation just spoils that and forces you back to square one, 
> to explicitly care about your files' contexts. Is there a fundamental
> reason why this is so (and can't be changed)?

SELinux isn't name-based.  rename() doesn't change your file mode or
ACLs either.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
