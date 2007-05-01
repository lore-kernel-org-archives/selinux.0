Subject: Re: MLS and no read up, no write down
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <637AC7CF-43ED-4078-BF5D-0A0604D3E314@sf-net.com>
References: <637AC7CF-43ED-4078-BF5D-0A0604D3E314@sf-net.com>
Content-Type: text/plain
Date: Tue, 01 May 2007 09:21:19 -0400
Message-Id: <1178025679.26421.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-01 at 10:06 +0200, Stefan Schulze Frielinghaus wrote:
> Hello,
> 
> in D. Bell and L. LaPadula "Secure Computer System: Unified  
> Exposition and Multics Interpretation" on page 42 the feature to  
> append something to a file is described as:
> 
> if attribute is append, current-level(subject) is dominated by level 
> (object);
> 
> Wouldn't this mean that someone with a security level e.g. of  
> unclassified could append something to a file labeled as top secret?  
> Isn't this a security problem? For example someone can't read a top  
> secret file but he could append rubbish or false information.
> 
> M. Bishop "Computer Security: Art and Science" describes the Bell  
> LaPadula model on page 125 even for write acces:
> 
> S can write O if and only if l(s) <= l(o) and S has discretionary  
> write access to O.
> 
> Is the SELinux MLS stuff exactly build like the Bell LaPadule theory?  
> The "no read up" theory sounds good and logical but the "no write  
> down" sounds suspicious. I would expect that if I write to a file  
> that the current level of the subject has to be equal to the level of  
> the object.
> 
> How is something like that handled by SELinux?

MLS/BLP is a confidentiality model, not an integrity model.  It is
usually used together with an integrity model such as Biba or Type
Enforcement (TE).

However, in many MLS systems, you are limited to writing at your level
(unless privileged) for the reason you describe.  In the case of
SELinux, the behavior is defined by the policy constraints (in
policy/mls) and the policy writer can configure it as desired.  In the
default mls policy in SELinux today, you are limited to writing at your
own level unless privileged (as determined based on your TE domain),
although that isn't strictly required by BLP and we do have TE as an
integrity mechanism.

Note btw that multi-level security can be implemented via Type
Enforcement (just map levels to types and define your allow rules to
match the BLP restrictions) if the discrete number of levels is not too
large, and real multi-level security needs are often met better by TE,
as it supports controlled information flow via assured pipelines. Even
if one needs the native MLS engine in SELinux (e.g. to support a huge
number of discrete levels due to many categories), TE provides a way to
confine and protect MLS trusted subjects and to provide integrity and
least privilege.  TE was originally designed to complement MLS in that
manner.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
