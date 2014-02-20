Date: Thu, 20 Feb 2014 21:21:34 +0000
From: Colin Walters <walters@verbum.org>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
To: Eric Paris <eparis@parisplace.org>
In-Reply-To: <CACLa4psP63Q7YYMxVA1Ei6r6AmDSrCGn+=q0-ZFrawUF2apQMA@mail.gmail.com>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
 <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
 <20140220192644.GA28064@tango.0pointer.de>
 <CACLa4puwTAN5Qjkp1AW__v9w2vyupG-BxmtfBsZ8cyXNWD-Ppg@mail.gmail.com>
 <53065B50.1030004@redhat.com>
 <20140220205709.BFC67C00005@frontend1.nyi.mail.srv.osa>
 <CACLa4psP63Q7YYMxVA1Ei6r6AmDSrCGn+=q0-ZFrawUF2apQMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-WEjjRfE7cu1Z447PF1El"
Message-Id: <20140220212635.7EC19C007AB@frontend1.nyi.mail.srv.osa>
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-WEjjRfE7cu1Z447PF1El
Content-Type: text/plain; charset=utf-8; format=flowed



On Thu, Feb 20, 2014 at 4:10 PM, Eric Paris <eparis@parisplace.org> 
wrote:
> I think the idea was
> 
> if we are not in the initrd - try to load policy
> if we are in the initrd and we find selinux_path() - try to load 
> policy
> 
> Thus embeded/thin who put everything inside the initrd will work (and
> the kernel enforce=1 will mean what is should)
> And where we don't put anything inside the initrd will still be
> correct since we'll try to load no matter what in the real root
> 
I guess then as long as we don't attempt to load policy again if we 
already have done so in the initrd - and yes, systemd already has logic 
of this form inside selinux_setup().

I'm testing this suggested patch now.





--=-WEjjRfE7cu1Z447PF1El
Content-Type: text/html; charset=utf-8



<br><br>On Thu, Feb 20, 2014 at 4:10 PM, Eric Paris &lt;eparis@parisplace.org&gt; wrote:<br>
<blockquote type="cite"><div class="plaintext" style="white-space: pre-wrap;">I think the idea was

if we are not in the initrd - try to load policy
if we are in the initrd and we find selinux_path() - try to load policy

Thus embeded/thin who put everything inside the initrd will work (and
the kernel enforce=1 will mean what is should)
And where we don't put anything inside the initrd will still be
correct since we'll try to load no matter what in the real root</div></blockquote><br><div>I guess then as long as we don't attempt to load policy again if we already have done so in the initrd - and yes, systemd already has logic of this form inside selinux_setup().</div><div><br></div><div>I'm testing this suggested patch now.</div><div><br></div><div><br></div><div><br></div>
--=-WEjjRfE7cu1Z447PF1El--
