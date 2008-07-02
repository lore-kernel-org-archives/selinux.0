Subject: Re: This patch adds permissive to semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <486BD1B6.5080908@manicmethod.com>
References: <4869037D.5040208@redhat.com>  <48691EB3.30706@manicmethod.com>
	 <1215000045.22447.252.camel@moss-spartans.epoch.ncsc.mil>
	 <486B7E03.1060304@manicmethod.com>
	 <1215004621.22447.273.camel@moss-spartans.epoch.ncsc.mil>
	 <486B848B.4020607@manicmethod.com>
	 <1215008940.22447.275.camel@moss-spartans.epoch.ncsc.mil>
	 <486BD1B6.5080908@manicmethod.com>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 15:13:22 -0400
Message-Id: <1215026002.22447.333.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-07-02 at 15:06 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2008-07-02 at 09:37 -0400, Joshua Brindle wrote:
> >> Stephen Smalley wrote:
> >>> On Wed, 2008-07-02 at 09:09 -0400, Joshua Brindle wrote:
> >>>> Stephen Smalley wrote:
> >>>>> On Mon, 2008-06-30 at 13:58 -0400, Joshua Brindle wrote:
> >>>>>> Daniel J Walsh wrote:
> >>>>>>> Gives users the ability to set a domain as permissive
> >>>>>>>
> >>>>>>>
> >>>>>>> semanage permissive -a http_t
> >>>>>>>
> >>>>>>> It created a policy module named permissive_httpd_t.pp with the
> >>>>>>> permissive call.
> >>>>>>>
> >>>>>> So, a really quick glance brings up a couple issues. First you have '-n', '--noheading' which aren't documented in the man page or elsewhere. Second (and more importantly) why are you executing semodule like that? libsemanage is the library that manages modules, and also the library used by semanage for everything else. 
> >>>>>>
> >>>>>> I would prefer a more 'pure' approach where we keep a list of
> >>>>>> permissive types and inject them into the kernel policy after linking
> >>>>>> (like libsemanage does with users, ports, nodes, etc) but I understand
> >>>>>> that adding a whole new set of databases and interfaces is both
> >>>>>> annoying and time consuming so I'm fine with it working on modules,
> >>>>>> I'd just like to see it using libsemanage interfaces instead of
> >>>>>> calling semodule.
> >>>>> Why do you see direct use of the libsemanage interfaces as preferable to
> >>>>> invoking semodule (aside from performance, and this isn't really
> >>>>> performance critical)?
> >>>>>
> >>>>> I'm unclear on the tradeoff being made there, as composing small
> >>>>> programs together to perform more complex operation is the Unix (tm)
> >>>>> way ;)
> >>>>>
> >>>>> The advantage of just invoking semodule is that semodule is already a
> >>>>> well-tested program that performs that function well, does proper error
> >>>>> checking and handling of the various libsemanage calls, etc.  And if we
> >>>>> later fix a bug or introduce new functionality there, we only have to do
> >>>>> it once vs. in multiple places.
> >>>>>
> >>>>> And the semanage permissive code already has to invoke a helper program
> >>>>> to compile the policy module from source to binary, at least today, so
> >>>>> it isn't much different to invoke semodule to install the binary module.
> >>>>>
> >>>>> Then there is the issue of being able to run the semodule stage of
> >>>>> processing in a separate domain, although at present semanage and
> >>>>> semodule operate in the same domain so it makes no difference at
> >>>>> present.
> >>>>>
> >>>> Maybe its just personal preference but I see using library interfaces
> >>>> as much more clean than invoking semodule and grepping. semanage
> >>>> already uses the library interfaces for everything else so this would
> >>>> be the one case where it doesn't. He already fixed it up to use the
> >>>> interfaces so its moot at this point. 
> >>> Well, it doesn't have to be moot - we can always take the first
> >>> implementation if we think it best.  But I'm not fundamentally opposed
> >>> to the latter approach, just wanted to explore the rationale.  One thing
> >>> I would note however is that I see lack of complete error return
> >>> checking in the new code that would have been properly checked by
> >>> semodule...
> >>>
> >> I'll fix the error checking in the second patch if you are fine with it otherwise. I just think the library is there for a reason, if we didn't want client programs using it we should have just built it into the application code. Feel free to veto me here if my rationale is weak (as it likely is).
> >>
> >> Maybe deep down inside I'm just not a unix programmer ;)
> > 
> > Ok, that's fine with me.
> > 
> > Maybe my own bias is just against python code compared to good olde C
> > programs!
> > 
> 
> Updated patch, unrelated things removed and error checking paths fixed up.
> 
> -----

> Index: policycoreutils/semanage/seobject.py
> ===================================================================
> --- policycoreutils/semanage/seobject.py	(revision 2917)
> +++ policycoreutils/semanage/seobject.py	(working copy)
> @@ -246,7 +248,108 @@
<snip>
> +	def add(self, type):
> +               name = "permissive_%s" % type
> +               dirname = "/var/lib/selinux"
> +               os.chdir(dirname)

Not new to the updated patch, but this can fail.

> +               filename = "%s.te" % name
> +               modtxt = """
> +module %s 1.0;
> +
> +require {
> +          type %s;
> +}
> +
> +permissive %s;
> +""" % (name, type, type)
> +               fd = open(filename,'w')

Can fail.

> +               fd.write(modtxt)

Can fail.

> +               fd.close()

Can fail.

> +               mc = module.ModuleCompiler()
> +               mc.create_module_package(filename, 1)

Can fail?

> +               fd = open("permissive_%s.pp" % type)

Can fail.

> +               data = fd.read()
> +               fd.close()
> +
> +               rc = semanage_module_install(self.sh, data, len(data));
> +               if rc < 0:
> +			raise ValueError(_("Could not set permissive domain %s (module installation failed)") % name)
> +               rc = semanage_commit(self.sh)
> +               if rc < 0:
> +			raise ValueError(_("Could not set permissive domain %s (commit failed)") % name)
> +               for root, dirs, files in os.walk("tmp", topdown=False):
> +                      for name in files:
> +                             os.remove(os.path.join(root, name))
> +                      for name in dirs:
> +                             os.rmdir(os.path.join(root, name))

No recursive removal function in python?
Do we need full pathnames here vs. relative ones?

> Index: policycoreutils/semanage/semanage.8
> ===================================================================
> --- policycoreutils/semanage/semanage.8	(revision 2917)
> +++ policycoreutils/semanage/semanage.8	(working copy)
> @@ -17,6 +17,8 @@
>  .br
>  .B semanage fcontext \-{a|d|m} [\-frst] file_spec
>  .br
> +.B semanage permissive \-{a|d} type
> +.br
>  .B semanage translation \-{a|d|m} [\-T] level
>  .P
>  
> @@ -101,10 +103,11 @@
>  $ semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
>  # Allow Apache to listen on port 81
>  $ semanage port -a -t http_port_t -p tcp 81
> +# Change apache to a permissive domain
> +$ semanage permissive -a http_t

Typo:  should be httpd_t, IIRC.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
