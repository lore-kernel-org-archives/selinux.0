Subject: Re: UNCLASSIFIED - Clarification of Symlink labelling...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "HAWKER, Dan 2 (external)" <Dan.HAWKER@uk4.astrium.eads.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7F6B06837A5DBD49AC6E1650EFF5490601C64C0E@auk52177.ukr.astrium.corp>
References: 
	 <7F6B06837A5DBD49AC6E1650EFF5490601C64C0E@auk52177.ukr.astrium.corp>
Content-Type: text/plain
Date: Fri, 25 Jan 2008 10:05:00 -0500
Message-Id: <1201273500.21288.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-01-25 at 14:37 +0000, HAWKER, Dan 2 (external) wrote:
> 
> Hi All,
> 
> Am presently in the process of creating some SELinux policies for some
> in house apps that run on our embedded devices. Thanks to some pointers
> and general advice from Stephen & Dave (Smalley and Sugar), have made a
> fair bit of headway so far and have something that is almost complete.
> Hurrah!!! :)
> 
> However am experiencing some strangeness regarding symlinks and am after
> either a *RTFM this* or a gentle pointer, because I am slightly
> confused...
> 
> Most of the apps I am creating policy for, are located in /opt. For
> example /opt/<various_appnames>, with the usual
> /opt/<various_appnames>/{bin, lib, blah} dirs enclosed. They are
> enclosed within the appname_t domain and labelled as follows
> appname_libs_t, appname_exec_t, etc. However we also have /opt/lib which
> includes symlinks to certain libraries located in
> /opt/<various_appnames>/lib that are shared across applications (ORB-TAO
> stuff for example).
> 
> Because of the default policy from system/libraries, these are
> automagically labelled lib_t, which is for the most part fine, however
> this causes apps that reference these symlinks to fail, as the app
> hasn't access to lib_t.
> 
> I have tried relabelling the symlinks directly using chcon and by
> editing my apps fc files to include these, however it never *takes*,
> they are always labelled lib_t, which is from the enclosing dir.
> 
> I can override this by changing the file context for the enclosing dir
> (/opt/lib in this case), however all the symlinks then take on the fc of
> the enclosing dir I stipulate, which although better than before is not
> ideal.
> 
> Is there any way to set symlinks directly or are the contexts always
> inherited from the enclosing dir???
> 
> Or am I just missing something very simple and hence doing something
> very stupid???

By default, newly created files inherit their type from the parent
directory.  Type transition rules in the policy can be used to alter
this behavior based on the creating domain, the parent directory type,
and the class of file.

The file contexts configuration (.fc files) is used by programs like rpm
to define the initial label to apply when installing a file and by
programs like restorecon to restore files to the original install-time
label.  But it doesn't affect labeling of files created at runtime by
ordinary programs (e.g. running ln -s is just going to leave the symlink
in the parent directory's type or whatever type is defined by the
applicable type transition rule).

What you could do is run restorecon on the symlinks in the %post
scriptlet of your spec file if you truly want them to be labeled
differently.

But allowing read access to lib_t:lnk_file is generally harmless if you
want to just permit it to your domain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
