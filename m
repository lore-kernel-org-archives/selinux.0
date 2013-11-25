Message-ID: <5293B163.9080307@tycho.nsa.gov>
Date: Mon, 25 Nov 2013 15:21:55 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: MLS required even when MLS is disabled?
References: <20131125201239.GA24780@siphos.be>
In-Reply-To: <20131125201239.GA24780@siphos.be>
Content-Type: multipart/mixed;
 boundary="------------000000090701030507000607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000000090701030507000607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/2013 03:12 PM, Sven Vermeulen wrote:
> Hi all
> 
> I have a report that mentions that the new userspace release does not like
> non-MLS policies:
> 
> # semanage fcontext -a -t swapfile_t "/swapfile"
> libsepol.context_from_record: MLS is disabled, but MLS context "s0" found (No such file or directory).
> libsepol.context_from_record: could not create context structure (Invalid argument).
> libsemanage.validate_handler: invalid context system_u:object_r:swapfile_t:s0 specified for /swapfile [all files] (Invalid argument).
> libsemanage.dbase_llist_iterate: could not iterate over records (Invalid argument).
> OSError: Invalid argument
> 
> # semanage login -a -s staff_u amade            
> libsemanage.validate_handler: MLS is disabled, but MLS range s0 was found for Unix user amade (No such file or directory).
> libsemanage.validate_handler: seuser mapping [amade -> (staff_u, s0)] is invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No such file or directory).
> OSError: No such file or directory
> 
> Any idea what could be the cause of this?

Probably this one.




--------------000000090701030507000607
Content-Type: text/x-patch;
 name="0001-If-users-of-seobject-set-serange-or-seuser-to-we-nee.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-If-users-of-seobject-set-serange-or-seuser-to-we-nee.pa";
 filename*1="tch"


--------------000000090701030507000607--
