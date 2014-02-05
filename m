Message-ID: <52F24F1B.4050009@tycho.nsa.gov>
Date: Wed, 05 Feb 2014 09:47:55 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Victor Porton <porton@narod.ru>, Eric Paris <eparis@parisplace.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: SELinux question..
References: <CA+55aFyaBZsF7u+Ka=0PRXQyF-vPyejgysoLsPAZdyf6Qn1KdA@mail.gmail.com>	<52F17412.3010105@schaufler-ca.com>
 <CACLa4pvZXRBSOXGnvcfnMWc-ZxcFwZQDjy7gfSDKWCeXiNCJxQ@mail.gmail.com>
 <52F24625.5000005@tycho.nsa.gov> <10921391611264@web22m.yandex.ru>
In-Reply-To: <10921391611264@web22m.yandex.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 James Morris <james.l.morris@oracle.com>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/05/2014 09:41 AM, Victor Porton wrote:
> MCS also has a use in sandboxing:
> 
> http://portonsoft.wordpress.com/2014/01/11/toward-robust-linux-sandbox/
> 
> By the way, it would help if you allow more than 1024 categories.
> 
> It is a good idea to build a category from the process ID of the calling program.
> 
> It can nevertheless be done with the current kernel assigning SEVERAL categories to MCS, having the list of categories determined by the process ID. But calculating several categories from one process ID is silly.
> 
> If I'd take the decision, I would allow any (possibly 64 bit) number as a category in MCS. Thus we would just pass process ID to SELinux when programming the sandbox.
> 
> P.S. Debian yet does not work well with enforcing SELinux. For this reason I have lied aside my project related with sandboxing for an indefinite time (until SELinux will work with my Debian).

Number of categories is policy-defined, not hardcoded, but there are
some current implementation aspects that make it more costly than it
should be to greatly expand them.  Besides, it is trivial to encode IDs
as category sets and this is already demonstrated through a variety of
existing implementations (at least openshift and Android, don't recall
if svirt and/or sandbox do the same).
