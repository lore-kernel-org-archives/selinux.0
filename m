Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA296PXZ004025
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 04:06:25 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA296OAw004495
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:06:24 GMT
Date: Tue, 2 Nov 2004 09:17:11 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, fedora-selinux-list@redhat.com,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: set/getxattrs - I am badly struck ..
Message-ID: <20041102091711.GU9643@lkcl.net>
References: <1099347144.9776.3.camel@jsingh> <1099347590.9784.3.camel@jsingh> <20041102003903.GR9643@lkcl.net> <1099378305.11007.13.camel@jsingh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099378305.11007.13.camel@jsingh>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

jaspreet, hi,

it sounds like you're endeavouring to do _exactly_ what i have been
trying to do: making a filesystem simultaneously available at a second
location.

realistically, you will need to examine types/files.fc and modify
genhomedircon.

i recommend you cut/paste genhomedircon's use of HOME_ROOT and HOME_DIR
to create a second set of macro substitutions VIRTUAL_HOME_ROOT and
VIRTUAL_HOME_DIR.

then, cut/paste the three or so lines in types/files.fc that use
HOME_ROOT and HOME_DIR, prepending VIRTUAL_ in the right places.

and you make sure that genhomedircon prepends /var/ whereever the new
substitutions VIRTUAL_ are used.

in this way, you will end up with a file_contexts that has
double-entries for /home and /var/home.

alternatively, ignore the above and hack genhomedircon to double-output
its lines: outputting both a line for /home and also an identical context
line for /var/home.


what _i_ did was restrict the system to only having one user: therefore
i can get away with using fusexmp to proxy mount /home/sez to
/Documents.

therefore, in the file contexts, i can get away without having to hack
genhomedircon, i can just add a hacked-up entry like this
files/misc/hack.sez.fc:

			/Documents 		sez:object_r:user_t.

l.

On Tue, Nov 02, 2004 at 12:21:45PM +0530, Jaspreet Singh wrote:
> Hi,
> 
> Thanx for the mail .. i have corrected the problem using audit2allow ..
> basically the domain needed permissions to access file-system.
> 
> Could you please help in this case .. I am struck in kernel space
> get/setxattrs (FC3-2.6.8-541 fs=etx3)
> 
> Should there be a difference between using user-space and kernel-space
> get/setxattrs to get/set file xattrs ...
> 
> 
> I have some trouble with using inode->i_op->get/setxattrs ...
> 
> i getxattr from /home and set it to /var/home using inode operations and
> get this -
> 
> ls -Zd /home /var/home
> drwxr-xr-x+ root     root  system_u:object_r:home_root_t    /home/
> drwxr-xr-x+ root     root  system_u:object_r:home_root_t    /var/home/
> 
> perfect till now .. but now when i try and create files inside /var/home
> they get the "root:object_r:var_t" unlike /home where i get
> "root:object_r:user_home_dir_t"  :-(
> 
> and on the contrary if i create /var/home and tag with "home_root_t"
> using setfiles it works perfectly fine ... any clues 
> 
> I cant use user-space get/setxattr coz I am writing a overlay
> file-system ... so ....
> 
> Does selinux intercept (and probably note down ) get/setxattrs syscalls
> or any of the type_tranistions.
> 
> any suggestions ....
> 
> Jaspreet Singh
> 

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
