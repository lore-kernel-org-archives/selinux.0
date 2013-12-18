Message-ID: <52B1E1AA.8090509@tycho.nsa.gov>
Date: Wed, 18 Dec 2013 12:55:54 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jay Corrales <jscorrales1122@gmail.com>
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>	<52B07D69.70209@tycho.nsa.gov>	<CACVacMvNNP3HLAEW_RhzuHxqUvq77nmApstS5V_xKoEG1zbZkA@mail.gmail.com>	<52B094C0.7080107@tycho.nsa.gov>	<CACVacMu4EvcdZzLVbBRFUvgg_RA0Mc7awZ0x_mzoxadmO6TSkw@mail.gmail.com>
 <CACVacMtV2+QbQiGvQRoDu3HaVd7p45BJFU01E7jKMdbJH06K1g@mail.gmail.com>
In-Reply-To: <CACVacMtV2+QbQiGvQRoDu3HaVd7p45BJFU01E7jKMdbJH06K1g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/18/2013 10:32 AM, Jay Corrales wrote:
> Folks,
>  
> We think we've run into a bug with rhel5. Could be that the policy
> database contains corruption, or contains some data structures that lead
> to buggy results (e.g. AVC execute_no_trans). Is there a way to see
> additional debug info in the LSM during run time? I've tried adding
> "debug" to the boot time kernel parameters, but does not add any new
> logging or reporting info for selinux.

More likely just a bug in your policy.  I can't really tell though as
you haven't shown an AVC that corresponds to the policy that you listed.
 You can easily check whether you did or did not allow something by
using sesearch from setools.
