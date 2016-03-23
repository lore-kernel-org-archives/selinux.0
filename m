Subject: Re: does it make sense that dac_override get's checked before
 dac_read_search?
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56F2B5F7.9050406@gmail.com> <56F2C7A5.1090303@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F2CCF9.8010407@gmail.com>
Date: Wed, 23 Mar 2016 18:06:01 +0100
MIME-Version: 1.0
In-Reply-To: <56F2C7A5.1090303@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/23/2016 05:43 PM, Stephen Smalley wrote:
> On 03/23/2016 11:27 AM, Dominick Grift wrote:
>> 
>> A long time ago Eric Paris hinted that the policy WRT
>> dac_override could probably be cleaned up.
>> 
>> I suspect that most of the the time dac_override is not needed
>> (too coarse). Instead dac_read_search would be sufficient for the
>> common scenario where root processes traverse locations where it
>> doesn't have DAC permissions to traverse.
>> 
>> The problem is that dac_override seems to be checked first. but 
>> dac_override , if i understand it, is broader than
>> dac_read_search
>> 
>> so why is dac_read_search not checked before dac_override?
> 
> I would be in favor of flipping the order of checks, but not sure
> how receptive upstream would be.  Outside of LSMs, the order
> doesn't matter since it isn't being audited, and checking
> CAP_DAC_OVERRIDE first does allow them to optimize for the case
> where the process has it.  In their world, the case where a process
> has CAP_DAC_READ_SEARCH but not CAP_DAC_OVERRIDE is rare.
> 
> A somewhat similar case was the order of checks in can_do_mlock,
> which did get reversed: commit
> a5a6579db33af91f4f5134e14be758dc71c1b694 Author: Jeff Vander Stoep
> <jeffv@google.com> Date:   Thu Mar 12 16:26:17 2015 -0700
> 
> mm: reorder can_do_mlock to fix audit denial
> 
> A userspace call to mmap(MAP_LOCKED) may result in the successful 
> locking of memory while also producing a confusing audit log
> denial. can_do_mlock checks capable and rlimit.  If either of these
> return positive can_do_mlock returns true.  The capable check leads
> to an LSM hook used by apparmour and selinux which produce the
> audit denial.  Reordering so rlimit is checked first eliminates the
> denial on success, only recording a denial when the lock is
> unsuccessful as a result of the denial.
> 
> However, in that case reordering the checks was more performant in
> the common case.
> 

I think i probably should be able to dontaudit these "pwd" traversal
attempts in the first place. It probably wont stop the command from
working.

If that is true then i also think it is not worth it.

And they do have a point because root reading state files on other
users might also be pretty common although most of the time these
state objects are world readable

There are basically 3 common scenarios in my experience:

setuid programs where a process wants to operate on some object with
unpriv uid/gid before it drops privileges

root reading state of unpriv processes

and root running commands from a unpriv users home dir: sudo

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8sz0AAoJECV0jlU3+UdpeCIL/2/kQ6FgR+TXs0Wtloc9JkST
/P2311Fcow3McVP1hvHSxpjte3smPymziDNsnXI5cIxH4OLGg8ANvMu8lJAH8Ynw
Xh9BBsfpnkqNJ9Xq17/P6+fgWQdpHZ5v46GsbTN1vJzbTUGTUsECqtykp1HMXzDB
OCWSMKtCorVePZjaXszkNtBzhBh9dtpBdQxfjwI0bQd42tHrXT2znVsEwPGHG+7j
S/osRJfgsvpBnwWTqurkO+215c5n2QV7S8efSZXESUqeCOKidwpMrCr+ddJx4yaj
V0CoOuO0qNPrtimBvv+GKYu8YWNCu8ZMf3DCZ10Y2GviJglyH3VXZiapT2V0PLZx
dCVEhQiRLBC8CocolSS4YiLqM2ZQTb+y13yxTcP2iVukmt56OUp2Z/hSxD09emnI
gXc/qLPG0WvMJyo4nO4VfoslIyvJqIYY4+O018NtX6+pENI5Pja2kiyEQZs+85AN
qiNksLVDLbogFvT7ywMz3ACHO6m1n0fihsi15pIEUw==
=gR9a
-----END PGP SIGNATURE-----
