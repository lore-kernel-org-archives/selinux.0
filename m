Message-ID: <53065B50.1030004@redhat.com>
Date: Thu, 20 Feb 2014 14:45:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>,
 Lennart Poettering <lennart@poettering.net>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
 <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
 <20140220192644.GA28064@tango.0pointer.de>
 <CACLa4puwTAN5Qjkp1AW__v9w2vyupG-BxmtfBsZ8cyXNWD-Ppg@mail.gmail.com>
In-Reply-To: <CACLa4puwTAN5Qjkp1AW__v9w2vyupG-BxmtfBsZ8cyXNWD-Ppg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/20/2014 02:27 PM, Eric Paris wrote:
> I like it, if it's reasonable/possible
> 
> On Thu, Feb 20, 2014 at 2:26 PM, Lennart Poettering 
> <lennart@poettering.net> wrote:
>> On Thu, 20.02.14 13:50, Eric Paris (eparis@parisplace.org) wrote:
>> 
>>> Not really.  If it doesn't exist on the final root fs and I put 
>>> enforcing=1 on the command line, I expect the box to 
>>> panic/fail/die/whatever....
>> 
>> OK, then maybe check "!in_initrd() || access("/etc/selinux/", F_OK) >=
>> 0"?
>> 
>> Lennart
>> 
>> -- Lennart Poettering, Red Hat
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
You mean

"!in_initrd() || access(selinux_path(), F_OK) >= 0"?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMGW1AACgkQrlYvE4MpobOeUgCg3YoRWatuabfOsAGLD4p09QVo
PYMAn3hDTBy4ePCPy/jORYlE+KGotSxE
=kkZx
-----END PGP SIGNATURE-----
