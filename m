Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4TLfSGx024813
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 17:41:28 -0400
Received: from pobox.globalherald.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4TLeglY028332
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 21:40:42 GMT
Received: from [192.168.1.135] (unknown [192.168.2.5])
	by pobox.globalherald.net (Postfix) with ESMTP id 67F5E1FD08A
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2010 20:03:08 -0400 (EDT)
Message-ID: <4C0189D1.3030301@globalherald.net>
Date: Sat, 29 May 2010 17:40:33 -0400
From: Joshua Kramer <josh@globalherald.net>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Non-Computing Abstractions & An Issue Thereof
Content-Type: multipart/mixed;
 boundary="------------080709020506080006020201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080709020506080006020201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am trying to wrap my head around using SELinux to secure data objects 
in userspace.  My learning style suggests that for a topic like this, I 
abstract the theory away from how it's actually implemented in 
software.  To those ends, I have created the type enforcement file 
attached to this email, that loosely models the behavior of teams of 
sled dogs using SELinux.

When I try to install the policy using these commands:

checkmodule -M -m -o seSledDogs.mod seSledDogs.te
semodule_package -o seSledDogs.pp -m seSledDogs.mod
semodule -i ./seSledDogs.pp

...I get this error from semodule:

libsepol.print_missing_requirements: seSledDogs's global requirements 
were not met: role dog_owner_r (No such file or directory).
libsemanage.semanage_link_sandbox: Link packages failed (No such file or 
directory).
semodule:  Failed!

If I comment out the roles, I get a similar message about the types:

libsepol.print_missing_requirements: seSledDogs's global requirements 
were not met: type/attribute medicine_t (No such file or directory).
libsemanage.semanage_link_sandbox: Link packages failed (No such file or 
directory).
semodule:  Failed!

Where do I need to be defining these roles and types?  I was under the 
impression that the te files were self-contained.

Thanks!
-Joshua Kramer



--------------080709020506080006020201
Content-Type: text/plain;
 name="seSledDogs.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="seSledDogs.te"


module seSledDogs 1.0;

require {

    # ----- SPECIFICATION.  This specifies what things are.

    # Classes.  The class describes a basic type of object
    # with which one can interact, and the interactions one
    # can have.  For example, with a _sled_ you can pull,
    # load, unload.  On the Linux side, an example of a
    # class is _file_: you can read, write, and perform
    # other operations on files.

    class sled { connect disconnect pull load unload embark disembark };
    class food { eat share }; 

    # Type definitions:  These describe the types of objects
    # with which the dogs will be interacting.  In this case
    # we have sleds that carry food, medicine, and people.

    # In the Linux world, Types describe the objects such
    # as files - for example, the files under /etc are
    # labelled with the type etc_t.

    type food_t;
    type medicine_t;
    type passenger_t;

    # Domains:  For this example, Domains are the functions
    # that are available to dogs.  Once a dog is assigned
    # a task (a "process"), the dog becomes part of a domain.
    # In dog terms the closest analogy is a Team - for example,
    # the instance of Dog named Nakita is on Team "Deliver
    # Medicine to Anchorage", hence domain meds_delivery_t.

    # In the Linux world, Domains are functions available to
    # particular programs or daemons.  For example, postgresql_t
    # is the Domain available for running instances of the
    # PostgreSQL daemon.

    type human_function_t;
    type dog_food_delivery_t;
    type dog_meds_delivery_t;
    type dog_people_delivery_t;
    type eating_t;

    # RBAC:  In this case, a 'role' describes a human
    # being that can interact with a dog.

    # In the Linux world, this is analogus to the roles such
    # as user_r, staff_r, and sysadm_r.

    role passenger_r;
    role sled_driver_r;
    role dog_owner_r;

} # end of 'require' statement

# ----- END SPECIFICATION

# ----- PERMISSIONS: What we allow and deny -----

# Permissions Rules:  Here we get to the meat of things.
# What should we allow, and what should we deny?  Note that
# anything that is not allowed here is denied; for example,
# dogs on the meds_delivery_t team cannot pull sleds
# of type passenger_t, because that is not explicitly
# permitted.

# Humans work in the 'human_function_t' domain.

# Humans can load and unload sleds of type food_t:
allow human_function_t food_t:sled { load unload };

# Humans can load and unload sleds of type medicine_t:
allow human_function_t medicine_t:sled { load unload };

# Humans can load, unload, embark, and disembark from
# sleds of type passenger_t:
allow human_function_t passenger_t:sled { load unload embark disembark };

# Humans can eat and share food of type food_t:
allow human_function_t food_t:food { eat share };

# Dogs, that are on the food delivery team (dog_food_delivery_t)
# can pull sleds of type food_t:
allow dog_food_delivery_t food_t:sled pull;

# Dogs on the meds_delivery_t team can pull sleds of type
# medicine_t:
allow dog_meds_delivery_t medicine_t:sled pull;

# Dogs on the people_delivery_t team can pull sleds of type
# passenger_t:
allow dog_people_delivery_t passenger_t:sled pull;


# All Dogs can eat and share food of type food_t:
allow dog_food_delivery_t food_t:food { eat share };
allow dog_meds_delivery_t food_t:food { eat share };
allow dog_people_delivery_t food_t:food { eat share };

# ----- END PERMISSIONS

--------------080709020506080006020201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
