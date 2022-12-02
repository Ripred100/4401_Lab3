function [aq, error] = outerController(qd,dqd,ddqd,dq,q,Kv,Kd)
aq = ddqd - (Kd*(q-qd))- (Kv*(dq-dqd));
error = qd-q;
end
