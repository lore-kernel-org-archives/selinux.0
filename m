Message-ID: <53C3D938.20307@tycho.nsa.gov>
Date: Mon, 14 Jul 2014 09:20:56 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Where does semanage store changes?
References: <53C2376F.7040805@gmail.com>
In-Reply-To: <53C2376F.7040805@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/13/2014 03:38 AM, dE wrote:
> Except when deleting and adding modules (when the main policy binary
> changes; did a checksum to verify that), where are other changes which
> semanage makes (like change boolean values, users, port, interface,
> node) stored?

Ultimately all of the changes you listed have to be stored in the kernel
policy binary since they are part of the kernel policy (unlike, for
example, semanage fcontext or login mappings).  However, they are also
kept in separate configuration files under
/etc/selinux/$SELINUXTYPE/modules/active and merged into the generated
kernel policy after linking and expanding the policy modules together.
Non-kernel configurations such as fcontext or login mappings are stored
in their own respective files, e.g. file_contexts.local and seusers.
