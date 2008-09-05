Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m85DRlkp016017
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 09:27:47 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m85DRl0F023756
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 13:27:47 GMT
Subject: Re: [refpolicy] Milter Mail Filters
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Howarth <paul@city-fan.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48982587.30605@city-fan.org>
References: <484D4B53.5020006@city-fan.org>
	 <1216385922.21191.125.camel@gorn>  <48982587.30605@city-fan.org>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 09:26:28 -0400
Message-Id: <1220621188.28287.79.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-08-05 at 11:03 +0100, Paul Howarth wrote:
> Christopher J. PeBenito wrote:
> > On Mon, 2008-06-09 at 16:25 +0100, Paul Howarth wrote:
> >> attached is a patch based on local policy I'm using on Fedora 9 to 
> >> support two "milter" mail filter daemons in conjunction with
> >> sendmail, 
> >> namely spamass-milter and milter-regex (I maintain the packages for
> >> both 
> >> of these in Fedora).
> >>
> >> I've taken the view that most milter applications will have similar 
> >> requirements and so I've created a milter_template interface that 
> >> contains most of what's needed, and then added the specifics that are 
> >> needed on top of the generic stuff for each application.

> >> +#============= milter-regex policy ==============
> >> +milter_template(regex)
> > 
> > As I mentioned before, it doesn't look like a template is needed, unless
> > you think there will be many more milter domains.  Then put all the
> > declarations in a section.
> 
> There are plenty of milters out there - see http://www.milter.org/milters
> 
> Not sure what you mean by "put all the declarations in a section". The 
> current version has very few declarations anyway now.

The style (including the commenting style) needs to match the rest of
refpolicy.  If you're invoking a template like this, it means there are
some declarations.  Other refpolicy modules have calls like this in the
declarations section.

> >> +interface(`milter_spamass_stream_connect',`
> >> +       gen_require(`
> >> +               type milter_spamass_var_run_t, milter_spamass_t;
> >> +       ')
> >> +       stream_connect_pattern($1,milter_spamass_var_run_t,milter_spamass_var_run_t,milter_spamass_t)
> >> +')
> >> +
> > 
> > Missing a files_search_spool().  Interface name needs to be fixed [1].
> 
> I have two interfaces now, common to all milters:
> 
> milter_stream_connect
> milter_getattr_socket_dir
> 
> I'll try claiming that "milter" is an abbreviation of "milters"; any 
> suggestions for better predicate names?

The target domain/object name, eg. milter_stream_connect_regex()

> I'm now using milter_$1_data_dir_t in the interface, where this 
> directory might live under /var/spool for some milters, /var/run for 
> others etc. So I added files_search_spool() in the te file for the 
> milter(s) that needed it (only).

It seems that milter_$1_data_dir_t and milter_$1_socket_t can be merged
into milter_$1_data_t.  They're all objects in the data dir, with
different classes.  The object class differentiation should be
sufficient IMO.

> Heavily revised patch attached. The individual milter policies are quite 
> brief now (and there are plenty more that could be added), which I think 
> justifies the template approach. No further changes should need to be 
> made to the sendmail and postfix policies to support additional milters 
> either.

The main thing that worries me about template usage is too many rules
going into them just for convenience.  We don't want rules that aren't
common to all milters.

> plain text document attachment (milters.patch)
[...]
> --- policy/modules/services/milters.te	(revision 0)
> +++ policy/modules/services/milters.te	(revision 0)
> @@ -0,0 +1,42 @@
> +policy_module(milters,0.1.4)
> +
> +require {
> +	attribute port_type;
> +}

This should be removed.

> +#============= declarations ================

The commenting style needs to be fixed.

[...]
> +interface(`milter_stream_connect',`
> +	gen_require(`
> +		attribute milter_socket_directories, milter_socket_type, milter_domains;
> +	')
> +	getattr_dirs_pattern($1,milter_socket_directories,milter_socket_directories)
> +	stream_connect_pattern($1,milter_socket_directories,milter_socket_type,milter_domains)
> +')

Needs to be named so that it shows that you can connect to all milters:
milter_stream_connect_all()

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
