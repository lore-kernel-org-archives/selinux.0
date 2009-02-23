Subject: Re: semanage fcontext --list doesn't list contexts which include
 HOME_DIR
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: Joe Nall <joe@nall.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40902231112n21f62bafk426737d8a399a75e@mail.gmail.com>
References: <cadfc0e40902230944q217ed46ar618dc06ccfa2e9fa@mail.gmail.com>
	 <A4219691-58AB-4D38-82C9-F4C593018ED9@nall.com>
	 <cadfc0e40902231112n21f62bafk426737d8a399a75e@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 23 Feb 2009 14:18:58 -0500
Message-Id: <1235416738.24868.74.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-02-23 at 13:12 -0600, Xavier Toth wrote:
> On Mon, Feb 23, 2009 at 12:50 PM, Joe Nall <joe@nall.com> wrote:
> >
> > On Feb 23, 2009, at 11:44 AM, Xavier Toth wrote:
> >
> >> Is there a different option or command I can use to see these?
> >
> > Is
> > cat /etc/selinux/mls/contexts/files/file_contexts.homedirs
> > complete?
> >
> > joe
> >
> >
> 
> I knew about /etc/selinux/mls/contexts/files/file_contexts.homedirs I
> was really just trying to point out that there appears to be a
> deficiency in `semanage fcontext --list`.

Yes, that's a deficiency of libsemanage in general; aside from
generating file_contexts.homedirs, it doesn't do anything else with it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
