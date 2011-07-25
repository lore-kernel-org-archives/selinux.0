Subject: Re: apol and active modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>
In-Reply-To: <201107252248.55086.russell@coker.com.au>
References: <201107242126.19144.russell@coker.com.au>
	 <4E2D6356.1070007@tresys.com>  <201107252248.55086.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Jul 2011 10:08:09 -0400
Message-ID: <1311602889.25226.27.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-07-25 at 22:48 +1000, Russell Coker wrote:
> On Mon, 25 Jul 2011, "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
> > On 07/24/11 07:26, Russell Coker wrote:
> > > Why can't apol (at least version 3.3.6.ds) parse the files in
> > > /etc/selinux/$SELINUXTYPE/modules/active/modules?  Is this considered a
> > > bug or a wontfix thing?
> > 
> > Can you be more specific about your usage?  There shouldn't be a problem
> > looking at those, since they're just a copy of what you install via
> > semodule -i/-b.
> 
> # diff /usr/share/selinux/default/base.pp \ 
> /etc/selinux/default/modules/active/base.pp 
> Binary files /usr/share/selinux/default/base.pp and 
> /etc/selinux/default/modules/active/base.pp differ
> 
> The files are not just a copy.
> 
> When /tmp/base.pp is a copy of /etc/selinux/default/modules/active/base.pp I 
> get the following:
> 
> $ apol  /tmp/base.pp 
> Initializing libqpol... done.
> Initializing libapol... done.
> Initializing libsefs... done.
> Initializing libapol_tcl... done.
> Initializing Tk... done.
> (unknown source)::ERROR 'syntax error' at token 'BZh91AY' on line 1:

BZh is the bzip2 magic string.  I'd guess your installed modules are
compressed (the default) and thus can't be opened by apol unless it
knows to decompress them first?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
