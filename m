Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UGhoOY026002
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 12:43:50 -0400
Subject: Re: libsepol segfaults with typealias and typealiasactual
To: <selinux@tycho.nsa.gov>
References: <20170530140513.GA29502@julius.enp8s0.d30>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <a2bfd9b2-5aa3-139c-31ea-5a6c226e3ef8@tresys.com>
Date: Tue, 30 May 2017 12:43:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170530140513.GA29502@julius.enp8s0.d30>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/30/2017 10:05 AM, Dominick Grift wrote:
> I have a typealias/typealiasactual in dssp2-standard at:
> 
> https://github.com/DefenSec/dssp2-standard/blob/master/policy/system/rpm.cil#L18
> 
> This *works*
> 
> However now i want to additionally associate "unconfined.user.subj" with "rpm_script_t"
> So i created a module:
> 
> echo "(typealiasesactual rpm_script_t unconfined.user.subj)" > mytest.cil && semodule -i mytest.cil
> it returns (something along those lines):
> 
> "subj is not an alias"
> 
> however it seems as though the module did install. I cannot think of any simple way to determine whether it works as I cannot find any "seinfo --typealias" or sesearch "--typealiases"
> 
> Anyway libsepol segfaults when i try to play more with this
> 
> So I tried the following
> 
> (typeattribute rpm_script_aliases_type_attribute)
> (typeattributeset rpm_script_aliases_type_attribute rpm.script.subj)
> (typeattributeset rpm_script_aliases_type_attribute unconfined.user.subj)
> 
> (typealias rpm_script_t)
> (typealiasactual rpm_script_t rpm_script_aliases_type_attribute)
> 
> This also return incoherent messages something like "invalid "." in ...", but it seems to install
> 
> and after that everything just segfaults (libsepol), untill i remove my local customizations
> 
> I dont know a better way to explain this but looks to me theres a serious bug in how typealiases are handled by libsepol:
> 
> https://www.youtube.com/watch?v=qe-vqieu2jg
> 

The first argument to the typealiasactual statement must resolve to a
typealias, and the second argument must resolve to a type. In your above
CIL snipppet you have it resolving to an attribute, which is not
allowed. However, we weren't correctly checking these restrictions,
which could lead to segfaults and weird error messages. I've just sent a
patch that should fix this conditions and error out with helpful messages.
