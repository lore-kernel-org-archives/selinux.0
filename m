Message-ID: <532C9A52.3070402@tycho.nsa.gov>
Date: Fri, 21 Mar 2014 16:00:18 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Subject: Re: The sepol_set_policydb method - to be used or not?
References: <20140321194741.GA11638@siphos.be>
In-Reply-To: <20140321194741.GA11638@siphos.be>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/21/2014 03:47 PM, Sven Vermeulen wrote:
> Hi all
> 
> In libsepol-2.2, I notice that the sepol_set_policydb() method is defined as
> "hidden", so I assume it is not meant to be used outside libsepol. That
> seems to be confirmed by nm:
> 
> $ nm -D /lib64/libsepol.so.1 | grep sepol_set_policydb
> 000000000002b8f0 T sepol_set_policydb_from_file
> 
> However, in libselinux-2.2.2 there is still reference to sepol_set_policydb():
> 
> src/audit2why.c : __policy_init():
>   sepol_set_policydb(&avc->policydb->p);
> 
> Should this still be happening?
> 
> We got a bug of a user that got the following stacktrace every time
> audit2why is imported through Python:
> 
> # semanage
> Traceback (most recent call last):
>   File "/usr/lib/python-exec/python2.7/semanage", line 27, in <module>
>     import seobject
>   File "/usr/lib64/python2.7/site-packages/seobject.py", line 27, in <module>
>     import sepolicy
>   File "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 11, in <module>
>     import sepolgen.interfaces as interfaces
>   File "/usr/lib64/python2.7/site-packages/sepolgen/interfaces.py", line 24, in <module>
>     import access
>   File "/usr/lib64/python2.7/site-packages/sepolgen/access.py", line 35, in <module>
>     from selinux import audit2why
> ImportError: /usr/lib64/python2.7/site-packages/selinux/audit2why.so: undefined symbol: sepol_set_policydb
> 
> Wkr,
> 	Sven Vermeulen
> 
> PS I need to clean my workstation up; I have the same packages/versions set
>    and I don't have the issue (yet), assuming the above is indeed wrong.

audit2why links libsepol.a; it is a user of the static library.
