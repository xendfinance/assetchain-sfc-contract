import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';

export default buildModule('MyToken', (m) => {
    const token = m.contract('Token', ['My Token', 'TKN', 18]);

    return { token };
});
