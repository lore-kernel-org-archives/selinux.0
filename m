Message-ID: <1372099441.28654.1.camel@dhcp137-13.rdu.redhat.com>
Subject: Re: pcre 8.33 changes restorecon behavior
From: Eric Paris <eparis@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Sven Vermeulen
	 <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Date: Mon, 24 Jun 2013 14:44:01 -0400
In-Reply-To: <51C85693.5040603@redhat.com>
References: <20130622161711.GA2010@siphos.be>
	 <51C840AB.2030606@tycho.nsa.gov> <51C85693.5040603@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-06-24 at 10:24 -0400, Daniel J Walsh wrote:
> On 06/24/2013 08:50 AM, Stephen Smalley wrote:
> > On 06/22/2013 12:17 PM, Sven Vermeulen wrote:
> >> Hi guys
> >> 
> >> Since libpcre 8.33, the behavior of restorecon is different. Take the 
> >> context for /sbin for instance:
> >> 
> >> Before libpcre 8.33: # matchpathcon /sbin /sbin
> >> system_u:object_r:bin_t:s0
> >> 
> >> With and after libpcre 8.33: # matchpathcon /sbin /sbin    <<none>>
> >> 
> >> As a result, trying to reset the label fails:
> >> 
> >> # restorecon -Fv /sbin restorecon:  Warning no default label for /sbin
> >> 
> >> Is this a bug in libpcre or are we using it differently? According to 
> >> Alphat-PC, it is due to rev 1313 of libpcre: 
> >> http://vcs.pcre.org/viewvc?view=revision&revision=1313
> >> 
> >> Thanks to Alphat-PC for reporting and debugging it at 
> >> https://bugs.gentoo.org/show_bug.cgi?id=471718
> > 
> > Looks to me as if the compiled regex format changed.  So that would be a
> > problem for previously compiled regexes cached in the .bin files under 
> > /etc/selinux/$SELINUXTYPE/contexts/files.  You would need to re-run 
> > sefcontext_compile to regenerate them or delete them and fall back to
> > loading from the source configurations.
> > 
> > Not sure if there is a way to automatically detect the change in format
> > and handle the conversion on the libselinux side.
> > 
> > 
> > 
> > -- This message was distributed to subscribers of the selinux mailing
> > list. If you no longer wish to subscribe, send mail to
> > majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> > as the message.
> We could add a trigger when pcre is updated to rerun the commands.
> 
> Adding something like the following to selinux-policy, would rebuild the pcre
> files.
> 
> %triggerin -- pcre
> selinuxenabled && semodule -nB
> exit 0

That's a wise packaging fix, but do we not get some sort of indication
from the library that we failed to be able to use the pre-compiled
regex's?  If we do get a failure of some sort, should the code be
dropping back to to use the text files instead?  I guess I can work to
get a system into this state eventually....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
