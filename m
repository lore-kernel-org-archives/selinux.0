Subject: Re: [SECILC] does not seem to filter redundant attributes and rules
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
Date: Wed, 9 Nov 2016 09:52:35 -0500
MIME-Version: 1.0
In-Reply-To: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/09/2016 07:40 AM, Dominick Grift wrote:
> I am in the process of a DSSP rewrite, taking a different approach this
> time.
>
> However I encountered something that seems suboptimal:
>
> SECILC seems to not filter redundant attributes and rules
>
> Example i have a type attribute and it has rules associated with it.
> However, the type attribute is not associated with any types.
>
> I was hoping that SECILC would be smart enough to determine that it
> might as well filter both the type attribute as well as the rules
> associated with it.
>
> To reproduce:
>
> git clone https://github.com/DefenSec/dssp1-base.git
> cd dssp1-base
> secilc `ls *.cil`
> sesearch -ASCT -s lib.ld_so.read_files_subj_type_attribute policy.30
> seinfo -xalib.ld_so.read_files_subj_type_attribute policy.30
>
>
> Am i expecting the impossible by expecting SECILC to be smart enough to
> determine that something is redundant, and that it can be filtered out
> until it becomes applicable?
>
>

I don't think that it would be too hard to remove attributes that have no types 
associated with them along with rules containing those attributes. I have this 
nagging feeling, though, that there is a reason that we didn't do that. I'll 
have to think about it a bit.

Jim


>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
