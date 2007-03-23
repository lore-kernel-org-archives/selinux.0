Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NNr0Av015992
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:53:00 -0400
Received: from facesaver.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NNqxBp015094
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 23:52:59 GMT
Received: from [144.51.25.7] (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id l2NNqxTb032332
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:52:59 -0400
Message-ID: <4604685B.301@tycho.nsa.gov>
Date: Fri, 23 Mar 2007 19:52:59 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Sample policy language extension supporting per-user policy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following came out of a private discussion on user management and 
SELinux.  It was poorly received, but I'm posting it here so it gets 
archived.

It's an idea for a policy language extension.  It is intended to reduce 
the size of the policy and the number of types.  It does this by 
providing support for per-user types natively instead of having to 
mangle the username onto the front of types.

The at sign (@) becomes a special character in the language extension. 
The words "group", "member", "each", and "all" become keywords.  The 
exact syntax isn't really as important as the idea.  But here goes:


1. User Attributes

Ability to define attributes ("groups") on users:
group admins;
user ewalsh roles staff_r;
member ewalsh, admins;

There is a fixed group "all" which includes every user.


2. Types and Attributes

The type declaration:
type @app_t;

Declares a type app_t as a "per-user" type.  With a per-user type, the 
user field of the security context counts as part of the type. 
Basically think of @app_t as a set of types, one for each user defined 
in the policy.

Same thing with per-user attributes:
attribute @attr;

Once a per-user type or attribute is defined, it must be referred to in 
all other statements prefixed with a user or group name, or the special 
keyword "each", to qualify it:

all@app_t means the whole set
ewalsh@app_t means only ewalsh's type
admins@app_t means the types of all users in admins.
each@app_t is used for one-to-one mappings, as will be seen.

Same thing with attributes.  Now for the semantics of putting attributes 
on types:

typeattribute all@app_file_t file_type;
Applies file_type to all the per-user types in @app_file_t.

typeattribute other_file_t all@app_file_type;
Applies all the per-user attributes in @app_file_type to other_file_t.

typeattribute each@app_file_t each@app_file_type;
Each per-user type in @app_file_t gets the corresponding (same user) 
attribute in @app_file_type: a one-to-one mapping.

typeattribute all@app_file_t all@app_file_type;
Applies every per-user attribute to every per-user type, which would 
probably be a rare thing.

Of course, "all" could be replaced with individual users or groups to 
narrow down the sets.


Granting Permissions

Same deal with allow rules:

allow each@app_t each@app_file_t:file read;
The most common scenario, this would allow the per-user domains to 
access the files carrying the corresponding per-user type.

allow all@app_t common_file_t:file read;
Allows all the per-user domains to access one file type.

allow common_t all@app_file_t:file read;
Allows a common domain to access all the per-user file types.

allow all@app_t all@app_file_t:file read;
Allows all per-user domains to access everyone's files.  Again, probably 
a rare thing.

Again, narrowing down is possible:

allow admins@app_t special_file_t:file read;
Would only allow the app_t domain to access special files when an admin 
user is running it.


File Contexts

Files would be labeled with the base type.  For example if the per-user 
type is @app_file_t, files would be labeled with app_file_t.  It should 
all just work, because the kernel will know app_file_t is per-user, and 
the user field will name the user in question.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
